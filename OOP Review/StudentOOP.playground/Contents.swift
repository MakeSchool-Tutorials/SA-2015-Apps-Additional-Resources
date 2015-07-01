//: Make School Extra Swift Review

import UIKit


//*Swift OOP*/

/*: Your job will be to create a MakeSchool class that conforms to the School protocol.
Here you are provided with some simple classes and protocols to get you started.
Your tasks:
1. Create the MakeSchool class and implement all functions.
2. Create an initializer for the MakeSchool class in which the founding date, location, and name are set.
3. Now create an instance of the MakeSchool class.
4. Create two confounder objects (Using a class that conforms to the CofounderDelegate protocol). Initialize them with how much time they work per week. Add the two cofounders to the cofounders dictionary. The key in the dictionary should be the cofounder's name.
5. Now implement all methods of the CofounderDelegate
6. One of MakeSchool's cofounders should now raise capital.
7. The other cofounder should hire a few employees.
8. Now enroll students by setting the array of students to this provided array:
[Student(name: "Mat", age: 20, id: "B5110", track: .Apps),
Student(name: "Sara", age: 18, id: "A5110", track: .Apps),
Student(name: "Norm", age: 19, id: "B5550", track: .Games)]
9. Generate an array of student names who are in the apps track. (Hint: Use two things in the lecture you watched yesterday.)
10. Create another instance of a business. Have MakeSchool acquire the business such that the appropriate function at least merges the employees. Feel free to do anything else that makes sense.
11. Now play around and break things.
*/




enum Track {
    
    case Apps
    case Games
    
}


class Student {
    
    init(name:String, age: Double, id:String, track:Track) {
        self.name = name
        self.id = id
        self.track = track
        self.age = age
    }
    
    var name:String
    var id:String
    var track: Track
    var age: Double
    
}

// This class keeps track of the company's current employees. Currently just has an array of names.
class WorkForce {
    
    var employees: [String]?
}

//This object stores the financial information of the company.  Currently just tracks the amount of cash the company has.
class Finance {
    var cash = 0.0
}

//This is a protocol that any Bussiness needs to conform to. This dictates that any class that conforms to this protocol will need to have all of these properties and methods.
protocol Bussiness {
    
    var name:String {get set}
    
    var location:String {get set}
    
    var foundedDate:NSDate {get set}
    
    var finances: Finance {get set}
    
    var workForce: WorkForce {get set}
    
    var cofounders: [String:FounderDelegate] {get set}
    
    func acquireAnotherBussiness(bussiness:Bussiness)-> Void
    
    func launchNewProduct(productName:String) -> Void
    
}

//The school protocol inherits from and extends the Bussiness protocol (Just like class inheritance). This means that any class that conforms to this School protocol will need to have all of the properties and methods from both Bussiness and School.

protocol  School: Bussiness{
    
    var students: [Student]? {get set}
}

//This is the Delegate protocol for a class that implements the school protocol.
protocol  FounderDelegate {
    
    var finances: Finance! {get set}
    
    var workForce: WorkForce! {get set}
    
    var maximumWorkHoursPerWeek: Double! {get set}
    
    func raiseCapital(capital:Double) -> Void
    
    func hireEmployee(employeeName:String) -> Void
    
    func fireEmployee(employeeName:String) -> Void
    
    func findPartnerships() -> Void
    
}


