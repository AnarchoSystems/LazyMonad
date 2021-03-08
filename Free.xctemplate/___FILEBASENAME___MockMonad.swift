//___FILEHEADER___


import Foundation


//use for testing and debugging
//if your monad requires to escape the continuation, feel free to change the protocol accordingly
//this should not be source breaking


public protocol ___VARIABLE_productName___MockInterpreter {
    
    func evaluate<S, T>(_ action: ___VARIABLE_productName___<S>, continuation: @escaping (S) -> ___VARIABLE_productName___MockMonad<T>) -> ___VARIABLE_productName___MockMonad<T>
    
}


public struct ___VARIABLE_productName___MockMonad<S> {
    
    //Yours to implement
    
}

public extension ___VARIABLE_productName___MockMonad {

    //please implement, Free depends on it
    
    static func pure(_ s: S) -> Self {
        fatalError("Yours to implement")
    }
    
    func flatMap<T>(_ transform: @escaping (S) -> ___VARIABLE_productName___MockMonad<T>) -> ___VARIABLE_productName___MockMonad<T> {
        fatalError("Yours to implement")
    }
    
    //map only needed if you want to implement any workflows in this monad
    
    func map<T>(_ transform: @escaping (S) -> T) -> ___VARIABLE_productName___MockMonad<T> {
        fatalError("Yours to implement")
    }
    
}
