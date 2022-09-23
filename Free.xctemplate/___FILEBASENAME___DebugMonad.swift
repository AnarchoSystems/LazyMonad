//___FILEHEADER___


import Foundation


//use for testing

public protocol ___VARIABLE_debugMonad___Interpreter {
    
    func evaluate<T>(_ action: ___VARIABLE_productName___<T>) -> ___VARIABLE_debugMonad___<T>
    
}


public struct ___VARIABLE_debugMonad___<S> {
    
    //Yours to implement
    
}

public extension ___VARIABLE_debugMonad___ {

    //please implement, Free depends on it
    
    static func pure(_ s: S) -> Self {
        fatalError("Yours to implement")
    }
    
    func flatMap<T>(_ transform: @escaping (S) -> ___VARIABLE_debugMonad___<T>) -> ___VARIABLE_debugMonad___<T> {
        fatalError("Yours to implement")
    }
    
    //map is only needed if you want to implement any workflows in this monad
    
    func map<T>(_ transform: @escaping (S) -> T) -> ___VARIABLE_debugMonad___<T> {
        fatalError("Yours to implement")
    }
    
}
