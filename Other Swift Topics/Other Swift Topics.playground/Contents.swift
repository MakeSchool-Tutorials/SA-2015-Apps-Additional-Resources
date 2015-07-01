

import UIKit


/*: Confusing properties*/
class someProperties {
    
    
    /*:Calculated once, the first time you acess property. Then stored for reuse*/
    lazy var first: NSDate = {
        
        return NSDate()
        }()
    
    
    
    /*:Recalculated every time you acess property*/
    var third: NSDate {
        return NSDate()
    }
    
    
    /*: Returns a closure. Closure needs to be execued to get the date.*/
    var second: () -> NSDate = {
        
        return NSDate()
    }
}

let test = someProperties().first

let test2 = someProperties().second()

let test3 = someProperties().third

