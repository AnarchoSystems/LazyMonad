//___FILEHEADER___

import Foundation


//Your DSL - do whatever you want 


public struct ___VARIABLE_productName___<T> {
 
    public let kind : Kind
    
    fileprivate init(_ kind: Kind){self.kind = kind}
    
    public enum Kind {
        case add(Int, continuation: (Bool) -> T)
        case remove(Int, continuation: (Bool) -> T)
        case filter((Int) -> Bool, continuation: ([Int]) -> T)
    }

}


extension ___VARIABLE_productName___ where T == Bool {
    
    static func add(_ value: Int) -> Self {
        ___VARIABLE_productName___(.add(value, continuation: {$0}))
    }
    
    static func remove(_ value: Int) -> Self {
        ___VARIABLE_productName___(.remove(value, continuation: {$0}))
    }
    
}


extension ___VARIABLE_productName___ where T == [Int] {
    
    static func getAll(_ pred: @escaping (Int) -> Bool) -> Self {
        ___VARIABLE_productName___(.filter(pred, continuation: {$0}))
    }
    
}
