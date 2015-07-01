//: Make School Extra Swift Review

import UIKit

//*Swift OOP*/

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
    
    var myCompany: Bussiness {get set}
    
    var maximumWorkHoursPerWeek: Double! {get set}
    
    func raiseCapital(capital:Double) -> Void
    
    func hireEmployee(employeeName:String) -> Void
    
    func fireEmployee(employeeName:String) -> Void
    
    func findPartnerships() -> Void
    
}

