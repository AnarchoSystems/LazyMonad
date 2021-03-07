//___FILEHEADER___

import Foundation


//Your DSL


public enum ___VARIABLE_productName___<Val, T> {
    
        case push(Val, T)
        case pop((Val?) -> Val, T)
        case add(T)
        case sub(T)
    
}

