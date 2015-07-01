//: Make School Extra Swift Review

import UIKit


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


