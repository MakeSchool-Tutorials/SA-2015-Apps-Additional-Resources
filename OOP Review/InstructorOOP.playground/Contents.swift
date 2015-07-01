//: Make School Extra Swift Review

import UIKit

/*:TODOS


Students do not have the instructions for this playground in their version of the playground. Instructors should provide the instructions an be  step-by-step in a slide such that everyone can work on the same step at the same time.

Instructors should discuss the use of the explicit "self." in closures.

Please review this before distributing to students and check for any errors and feel free to add some more appropriate optional usage and checking.


End TODOS*/


//*Swift OOP*/

/*: Your job will be to create a MakeSchool class that conforms to the School protocol.
Here you are provided with some simple classes and protocols to get you started.
Your tasks:
1. Create the MakeSchool class and implement all functions.
2. Create an initializer for the MakeSchool class in which the founding date, location, and name are set.
3. Now create an instance of the MakeSchool class.
4. Create a MakeSchoolCofounder class that conforms to the CofounderDelegate protocol. Initialize two MakeSchoolCofounder objects with how much time they work per week and their name. Add the two cofounders to the cofounders dictionary. The key in the dictionary should be the cofounder's name.
6. One of MakeSchool's cofounders should now raise capital. Here the company is delegating this task to a cofounder (i.e a Delegate)
7. The other cofounder should hire a few employees. The compnay is also delegating tasks to the other cofounder delegate.
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
    
    var name:String {get set}
    
    var finances: Finance! {get set}
    
    var workForce: WorkForce! {get set}
    
    var maximumWorkHoursPerWeek: Double! {get set}
    
    func raiseCapital(capital:Double) -> Void
    
    func hireEmployee(employeeName:String) -> Void
    
    func fireEmployee(employeeName:String) -> Void
    
    func findPartnerships() -> Void
    
}


/*:Potential Solution*/



class MakeSchool: School {
    
    init (name:String,location:String,foundedDate:NSDate) {
        self.name = name
        self.location = location
        self.foundedDate = foundedDate
        
    }
    var name:String
    
    var students: [Student]?
    
    var location:String
    
    var foundedDate:NSDate
    
    var finances = Finance()
    
    var workForce = WorkForce()
    
    var cofounders: [String:FounderDelegate] = [:]
    
    func acquireAnotherBussiness(bussiness:Bussiness) {
        //Add the workforces together
        workForce.employees! += bussiness.workForce.employees!
    }
    
    func launchNewProduct(productName:String) {
        //Tells us we launched
        println("We launched \(name)")
    }
}

class  MakeSchoolCofounder: FounderDelegate {
    
    init(name:String,maximumWorkHoursPerWeek:Double){
        self.name = name
        self.maximumWorkHoursPerWeek = maximumWorkHoursPerWeek
    }
    
    var name:String
    
    var finances: Finance!
    
    var workForce: WorkForce!
    
    var maximumWorkHoursPerWeek: Double!
    
    func raiseCapital(capital:Double) {
        finances.cash += capital
    }
    
    func hireEmployee(employeeName:String) {
        workForce.employees!.append(employeeName)
    }
    
    func fireEmployee(employeeName:String) {
        workForce.employees =  workForce.employees!.filter {$0 != employeeName}
    }
    
    func findPartnerships() {
        println("Sucess. We have a new partnership!! Party!!")
    }
    
}


//Create MakeSchool instance
let makeschool = MakeSchool(name: "MakeSchool", location: "San Fransisco", foundedDate: NSDate())

//Add cofounders
makeschool.cofounders["Jeremy"] = MakeSchoolCofounder(name: "Jeremy", maximumWorkHoursPerWeek: 126)
makeschool.cofounders["Ashu"] = MakeSchoolCofounder(name:"Ashu", maximumWorkHoursPerWeek: 125.4)



//Cofounders do things
makeschool.cofounders["Jeremy"]!.finances = makeschool.finances
makeschool.cofounders["Jeremy"]!.raiseCapital(500000)
makeschool.cofounders["Jeremy"]!.findPartnerships()

makeschool.cofounders["Ashu"]?.workForce = makeschool.workForce
makeschool.cofounders["Ashu"]?.hireEmployee("Tom")

//Enroll  students
makeschool.students = [Student(name: "Mat", age: 20, id: "B5110", track: .Apps),Student(name: "Sara", age: 18, id: "A5110", track: .Apps),Student(name: "Norm", age: 19, id: "B5550", track: .Games)]

//Get certain students
let appTrackStudents =  makeschool.students?.filter{$0.track == Track.Apps}.map{$0.name}


