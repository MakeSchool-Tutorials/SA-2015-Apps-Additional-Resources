//: Make School Extra Swift Review

import UIKit

/*:TODOS

Extend the playground to cover the "weak" concept.

Instructors should discuss the use of the explicit "self." in closures.

Please review this before distributing to students and check for any errors and feel free to add some more appropriate optional usage and checking.

For the OOP section, the student version of this file can either be provided as is or
the instructions can be provided step-by-step in a slide such that everyone can work on
the same step at the same time.

End TODOS*/


//*Swift OOP*/

/*: Your job will be to create a MakeSchool class that conforms to the School protocol.
Here you are provided with some simple classes and protocols to get you started.
Your tasks:
1. Create the MakeSchool class and implement all functions.
2. Create an initializer for the MakeSchool class in which the founding date, location, and name are set.
3. Now create an instance of the MakeSchool class and add two cofounders to the cofounders dictionary. (Init cofounds with how much time they work per week)
4. Now implement all methods of the CofounderDelegate
5. One of MakeSchool's cofounders should now raise capital.
6. The other cofounder should hire a few employees.
7. Now enroll students by setting the array of students to this provided array:
[Student(name: "Mat", age: 20, id: "B5110", track: .Apps),
Student(name: "Sara", age: 18, id: "A5110", track: .Apps),
Student(name: "Norm", age: 19, id: "B5550", track: .Games)]
7. Generate an array of student names who are in the apps track. (Hint: Use two things in the lecture you watched yesterday.)
8. Create another instance of a business. Have MakeSchool acquire the business such that the appropriate function at least merges the employees. Feel free to do anything else that makes sense.
9. Now play around and break things.
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


class WorkForce {
    
    var employees: [String]?
}

class Finance {
    var cash = 0.0
}

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

protocol  School: Bussiness{
    
    var students: [Student]? {get set}
}


protocol  FounderDelegate {
    
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

class  Jeremy: FounderDelegate {
    
    init(maximumWorkHoursPerWeek:Double){
        self.maximumWorkHoursPerWeek = maximumWorkHoursPerWeek
    }
    
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
        //remove from workforce
    }
    
    func findPartnerships() {
        println("Sucess. We have a new partnership!! Party!!")
    }
    
}

class  Ashu: FounderDelegate {
    init(maximumWorkHoursPerWeek:Double){
        self.maximumWorkHoursPerWeek = maximumWorkHoursPerWeek
    }
    
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
        
    }
    
}


//Create MakeSchool instance
let makeschool = MakeSchool(name: "MakeSchool", location: "San Fransisco", foundedDate: NSDate())

//Add cofounders
makeschool.cofounders["Jeremy"] = Jeremy(maximumWorkHoursPerWeek: 126)
makeschool.cofounders["Ashu"] = Ashu(maximumWorkHoursPerWeek: 125.4)



//Cofounders do things
makeschool.cofounders["Jeremy"]!.finances = makeschool.finances
makeschool.cofounders["Jeremy"]!.raiseCapital(500000)
makeschool.cofounders["Jeremy"]!.findPartnerships()

makeschool.cofounders["Ashu"]?.workForce = makeschool.workForce
makeschool.cofounders["Ashu"]?.hireEmployee("Tom")

//Enroll  students
makeschool.students = [Student(name: "Mat", age: 20, id: "B5110", track: .Apps),Student(name: "Sara", age: 18, id: "A5110", track: .Apps),Student(name: "Norm", age: 19, id: "B5550", track: .Games)]

//Get certain students
let appTrackStudents =  makeschool.students?.filter {$0.track == Track.Apps}.map{$0.name}


