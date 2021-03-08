//___FILEHEADER___


import Foundation


//use for production
//if your monad requires to escape the continuation, feel free to change the protocol accordingly
//this should not be source breaking


public protocol ___VARIABLE_productName___TargetInterpreter {
    
    func evaluate<S, T>(_ action: ___VARIABLE_productName___<S>, continuation: (S) -> ___VARIABLE_productName___TargetMonad<T>) -> ___VARIABLE_productName___TargetMonad<T>
    
}


public struct ___VARIABLE_productName___TargetMonad<S> {
    
    //Yours to implement
    
}

public extension ___VARIABLE_productName___TargetMonad {

    //please implement, Free depends on it
    
    static func pure(_ s: S) -> Self {
        fatalError("Yours to implement")
    }
    
    //map and flatMap only needed if you want to implement any workflows in this monad
    
    func map<T>(_ transform: @escaping (S) -> T) -> ___VARIABLE_productName___TargetMonad<T> {
        fatalError("Yours to implement")
    }
    
    func flatMap<T>(_ transform: @escaping (S) -> ___VARIABLE_productName___TargetMonad<T>) -> ___VARIABLE_productName___TargetMonad<T> {
        fatalError("Yours to implement")
    }
}
