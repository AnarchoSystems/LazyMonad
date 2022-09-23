//___FILEHEADER___


import Foundation


//use for production


public protocol ___VARIABLE_productionMonad___Interpreter {
    
    func evaluate<T>(_ action: ___VARIABLE_productName___<T>) -> ___VARIABLE_productionMonad___<T>
    
}


public struct ___VARIABLE_productionMonad___<S> {
    
    //Yours to implement
    
}

public extension ___VARIABLE_productionMonad___ {

    //please implement, Free depends on it
    
    static func pure(_ s: S) -> Self {
        fatalError("Yours to implement")
    }
    
    func flatMap<T>(_ transform: @escaping (S) -> ___VARIABLE_productionMonad___<T>) -> ___VARIABLE_productionMonad___<T> {
        fatalError("Yours to implement")
    }
    
    //map is only needed if you want to implement any workflows in this monad
    
    func map<T>(_ transform: @escaping (S) -> T) -> ___VARIABLE_productionMonad___<T> {
        fatalError("Yours to implement")
    }
    
}
