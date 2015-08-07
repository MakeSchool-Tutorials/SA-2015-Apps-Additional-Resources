import Foundation

//: ## Memory Management in Swift, or lack thereof -- ARC!
//:
//: ----
//: 
//: Every variable we create using `var` or `let` physically exists in our computer's memory or RAM as a series of 1s and 0s.
//: We have a large but limited amount of memory, and filling it up will slow down our code, so we typically want to 
//: keep the amount of memory we use to a minimum. The line:

var i: Int = 1

//: Reserves some space in memory to store `i`. Specifically, Ints require 4 bytes of memory. We can see that if 
//: we were to continually create variables in our code without destroying them, we'd run out of memory! 
//: The good thing is that Swift manages the lifetime of our variables for us, we don't have to worry about
//: manually deleting our variables to free up memory for future variables. Take for instance the following function:

func doSomething()
{
  var oneThing = "never"
  var twoThing = "gonna"
  var redThing = "give"
  var blueThing = "you up"
}

//: When we call the function `doSomething`, it creates 4 different variables. Once the function finishes, Swift notices
//: that these variables are no longer in use, and destroys them. We can see this if we define our own class and print
//: on initialization and deinitialization.
//:
//: ----
//:
//: Paste the following code in at [http://swiftstub.com](http://swiftstub.com)

var numberOfThings = 0

class Thing {
  var name: String?
  
  init() {
    println("A new thing has been made! Total things in existence: \(++numberOfThings)")
  }
  
  deinit {
    println("A thing has been deleted. Total things in existence: \(--numberOfThings)")
  }
}

Thing()

//: When we created that last `Thing`, it was immediately destroyed. Why's that?

//: Swift's memory management model is called: Automatic Reference Counting, or ARC. This means that Swift keeps track
//: of how many variables are using the same reference.

var thing1 = Thing()
var thing2 = thing1

//: Remember that the code above does not create two separate instaces of `Thing`, but `thing2` now "points to" `thing1`.
//: `thing2` has essentially become a new name for `thing1`. If we change `thing2`'s `name` property, we'll see that the
//: same changes are applied to `thing1`

thing1.name = "Larry"
thing2.name = "Sally"
println(thing1.name!)

//: When we assign a variable to a new instance of an object, we create an object with a reference count of 1, that is:
//: we have one variable in use that points to the instance. When we assign a new variable equal to the first, no new 
//: object is being instantiated, instead we simply let this new variable point to the same piece of memory that the first
//: does. When we do this, we increment the reference count of the object to 2.
//:
//: ----
//:
//: Add the following code to the end of the existing code at [http://swiftstub.com](http://swiftstub.com) with:

var thing3: Thing? = Thing()
println("Thing3's reference count: \(CFGetRetainCount(thing3) - 1)")

var thing4: Thing? = thing3
println("Thing3's reference count: \(CFGetRetainCount(thing3) - 1)")

thing3 = nil
println("Thing3's reference count: \(CFGetRetainCount(thing4) - 1)")

thing4 = nil

//: It's only until we make all our variables that point to this object go away (by going out of scope), or point to 
//: something else that this reference count reaches 0 and our object is finally destroyed

//: OK that's all nice to know, but why do I care? For the most part, you really don't have to worry about this.
//: However, check out what happens in the following example.
//:
//: ----
//:
//: Replace your code at [http://swiftstub.com](http://swiftstub.com) with:

class Country {
  let name: String
  let capitalCity: City!
  init(name: String, capitalName: String) {
    self.name = name
    capitalCity = City(name: capitalName)
    capitalCity.country = self
    println("A new country has been made")
  }
  
  deinit {
    println("A country has been destroyed")
  }
}

class City {
  let name: String
  var country: Country?
  init(name: String) {
    self.name = name
    println("A new city has been made")
  }
  
  deinit {
    println("A city has been destroyed")
  }
}

Country(name: "USA", capitalName: "Washington DC")

//: We can see by the print statements that both a `Country` and a `City` have been created, but we haven't stored
//: the `Country` in a variable, so it should have been destroyed, right? 

//: What we've done here is that we've created a **retain cycle**. This is bad! `Country` has a `City`, so its `city`
//: property has a reference count of 1, and the same `city` has a property `country` that has been set to the `country`
//: that it is contains this same `city`, so `country`'s reference count is also 1. You can see now why it's called
//: a cycle, and because both objects have a reference count above 0, neither of them are ever able to be destroyed
//: by Swift and ARC.

//: It makes sense for the country to have a capital, and it also makes sense for a city to have information about which
//: country it resides in, so how do we fix this without removing properies? Enter the `weak` keyword. `weak` denotes a
//: variable that should **not** increase the reference count of the object it's assigned to. 
//:
//: ----
//:
//: Go ahead and change `City`'s property `country` in [http://swiftstub.com](http://swiftstub.com) to:

weak var country: Country?

//: And confirm that our objects can now be cleaned up by ARC!

//: That was somewhat of a contrived example, so let's do one more example that you've likely come across already.
//: Closures automatically store references to the variables they need to excecute the code within the closure, so 
//: the following example shows how this can also lead to a retain cycle.
//:
//: ----
//:
//: Replace the code in [http://swiftstub.com](http://swiftstub.com) to:

class ClosureHolder {
  var closure: (() -> Void)!
}

class DoesSomething {
  var closureHolder: ClosureHolder
  
  init() {
    closureHolder = ClosureHolder()
    closureHolder.closure = {
      self.doSomething()
    }
    println("A new DoesSomething has been made")
  }
  
  deinit {
    println("A DoesSomething has been destroyed")
  }
  
  func doSomething() {}
}

DoesSomething()

//: As you can see, because the instance of `DoesSomething` holds a `ClosureHolder`, and that `ClosureHolder`'s closure 
//: captures a reference to `DoesSomething` in order to carry out the code within the closure (`self.doSomething()`), 
//: we've created a retain cycle and the instance of `DoesSomething` never gets destroyed!
//:
//: This is fixed easily enough by simply adding `[unowned self]` to the capture list of the closure. `unowned` and `weak`
//: mean almost the same thing, the difference is that `unowned` variables are expected to never be `nil`, which should
//: definitely be the case for our use of `self`.
//:
//: ----
//:
//: Replace the line 
    closureHolder.closure = {
//: To:
    closureHolder.closure = { [unowned self] in
//: And once again confirm that ARC was successfully able to destroy the instance of `DoesSomething` for us automatically.
