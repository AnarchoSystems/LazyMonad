//___FILEHEADER___

import Foundation



//MARK: DON'T CHANGE


//It shouldn't be necessary to change the below code other than for renaming purposes


///A ___VARIABLE_productName___FunctorImplementation contains the actual implementation of map.
public protocol ___VARIABLE_productName___FunctorImplementation {
    
    ///This method describes how functions from S to T should be lifted to functions from ___VARIABLE_productName___<Val, S> to ___VARIABLE_productName___<Val, T>.
    /// - Parameters:
    ///     - value: The value before the call to transform.
    ///     - transform: A function operating on the generic type argument.
    /// - Returns: The mapped ___FILEBASENAMEASIDENTIFIER___.
    func map<Val,S,T>(_ value: ___VARIABLE_productName___<Val, S>,
                  _ transform: @escaping (S) -> T) -> ___VARIABLE_productName___<Val, T>
    
}


public extension ___VARIABLE_productName___ {
    
    ///Coyoneda allows you to define workflows on your fake functor type without specifying an implementation of map.
    struct Coyoneda {
        
        let chain : (___VARIABLE_productName___FunctorImplementation) -> ___VARIABLE_productName___
        
    }
    
    ///Coyoneda allows you to define workflows on your fake functor type without specifying an implementation of map.
    static func coyoneda(_ value: ___VARIABLE_productName___) -> Coyoneda {
        Coyoneda{_ in value}
    }
    
    
}


public extension ___VARIABLE_productName___.Coyoneda {
    
    
    typealias ___VARIABLE_productName___U<U> = ___VARIABLE_productName___<Val, U>
    
    
    ///Actually runs the functor chain with the given implementation.
    /// - Parameters:
    ///     - impl: The monad implementation.
    /// - Returns: The result of the monad chain.
    func runUnsafe(_ implementation: ___VARIABLE_productName___FunctorImplementation) -> ___VARIABLE_productName___ {
        chain(implementation)
    }
    
    
    ///Applies a transformation to the underlying vanilla value.
    /// - Parameters:
    ///     - transform: The transformation to apply.
    /// - Returns: The mapped value according to the (deferred) map implementation.
    func map<U>(_ transform: @escaping (T) -> U) -> ___VARIABLE_productName___U<U>.Coyoneda {
        .init{impl in
            impl.map(chain(impl), transform)
        }
    }
    
}
