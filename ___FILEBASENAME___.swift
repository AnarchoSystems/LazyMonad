//___FILEHEADER___

import Foundation



public enum ___FILEBASENAMEASIDENTIFIER___<T> {
    
    case value(T, sideEffect: Any?)
    case failure(Error)
    
    
    //If you change the implementation, please make sure the signature stays the same
    public static func pure(_ value: T) -> Self {
        .value(value, sideEffect: nil)
    }
    
}


//MARK: - DON'T CHANGE


//It shouldn't be necessary to change the below code other than for renaming purposes


///A ___FILEBASENAMEASIDENTIFIER___MonadImplementation contains the actual implementation of ma and flatMap and allows to decorate vanilla functios of ___FILEBASENAMEASIDENTIFIER___.
public protocol ___FILEBASENAMEASIDENTIFIER___MonadImplementation {
    
    
    ///This method is an extension point for usual functions operating on ___FILEBASENAMEASIDENTIFIER___s. It will only be called on actual arrows between ___FILEBASENAMEASIDENTIFIER___s, but not on map or flatMap.
    /// - Paramaters:
    ///     - value: The value before the call to transform.
    ///     - transform: The function to apply to value.
    /// - Returns: The result of the function call after pre- and postprocessing.
    func decorate<S,T>(_ value: ___FILEBASENAMEASIDENTIFIER___<S>,
                   _ transform: @escaping (___FILEBASENAMEASIDENTIFIER___<S>) -> ___FILEBASENAMEASIDENTIFIER___<T>) -> ___FILEBASENAMEASIDENTIFIER___<T>
    
    
    ///This method describes how functions from S to T should be lifted to functions from ___FILEBASENAMEASIDENTIFIER___<S> to ___FILEBASENAMEASIDENTIFIER___<T>.
    /// - Parameters:
    ///     - value: The value before the call to transform.
    ///     - transform: A function operating on the generic type argument.
    /// - Returns: The mapped ___FILEBASENAMEASIDENTIFIER___.
    func map<S,T>(_ value: ___FILEBASENAMEASIDENTIFIER___<S>,
                  _ transform: @escaping (S) -> T) -> ___FILEBASENAMEASIDENTIFIER___<T>
    
    
    ///This method describes how functions from S to ___FILEBASENAMEASIDENTIFIER___<T> should be lifted to functions from ___FILEBASENAMEASIDENTIFIER___<S> to ___FILEBASENAMEASIDENTIFIER___<T>.
    /// - Parameters:
    ///     - value: The value before the call to transform.
    ///     - transform: A function operating on the generic type argument.
    /// - Returns: The flatmapped ___FILEBASENAMEASIDENTIFIER___.
    func flatMap<S,T>(_ value: ___FILEBASENAMEASIDENTIFIER___<S>,
                      _ transform: @escaping (S) -> ___FILEBASENAMEASIDENTIFIER___<T>) -> ___FILEBASENAMEASIDENTIFIER___<T>
    
}


public extension ___FILEBASENAMEASIDENTIFIER___MonadImplementation {
    
    //default implementation: just call the function
    func decorate<S,T>(_ value: ___FILEBASENAMEASIDENTIFIER___<S>,
                       _ transform: @escaping (___FILEBASENAMEASIDENTIFIER___<S>) -> ___FILEBASENAMEASIDENTIFIER___<T>) -> ___FILEBASENAMEASIDENTIFIER___<T> {
        transform(value)
    }
    
}


public extension ___FILEBASENAMEASIDENTIFIER___ {
    
    ///Coyoneda allows you to define workflows on your fake monadic type without specifying an implementation of map and flatMap.
    struct Coyoneda {
        
        let chain : (___FILEBASENAMEASIDENTIFIER___MonadImplementation) -> ___FILEBASENAMEASIDENTIFIER___<T>
        
    }
    
    ///Coyoneda allows you to define workflows on your fake monadic type without specifying an implementation of map and flatMap.
    static func coyoneda(_ value: T) -> Coyoneda {
        Coyoneda(.pure(value))
    }
    
    
}

public extension ___FILEBASENAMEASIDENTIFIER___.Coyoneda {
    
    init(_ value: ___FILEBASENAMEASIDENTIFIER___<T>) {
        chain = {_ in value}
    }
    
    static func pure(_ value: T) -> Self {
        Self(.pure(value))
    }
    
}


public extension ___FILEBASENAMEASIDENTIFIER___.Coyoneda {
    
    
    ///Actually runs the monad chain with the given implementation.
    /// - Parameters:
    ///     - impl: The monad implementation.
    /// - Returns: The result of the monad chain.
    func runUnsafe(_ implementation: ___FILEBASENAMEASIDENTIFIER___MonadImplementation) -> ___FILEBASENAMEASIDENTIFIER___<T> {
        chain(implementation)
    }
    
    
    ///Applies a transformation to the ___FILEBASENAMEASIDENTIFIER___ as a whole.
    /// - Parameters:
    ///     - transform: The function to apply.
    /// - Returns: The result of the function call, potentially with pre- and postprocessing.
    func apply<U>(_ transform: @escaping (___FILEBASENAMEASIDENTIFIER___<T>) -> ___FILEBASENAMEASIDENTIFIER___<U>) -> ___FILEBASENAMEASIDENTIFIER___<U>.Coyoneda {
        .init {impl in
            impl.decorate(chain(impl), transform)
        }
    }
    
    
    ///Applies a transformation to the underlying vanilla value.
    /// - Parameters:
    ///     - transform: The transformation to apply.
    /// - Returns: The mapped value according to the (deferred) map implementation.
    func map<U>(_ transform: @escaping (T) -> U) -> ___FILEBASENAMEASIDENTIFIER___<U>.Coyoneda {
        .init{impl in
            impl.map(chain(impl), transform)
        }
    }
    
    
    ///Applies an effectful transformation to the underlying vanilla value.
    /// - Parameters:
    ///     - transform: The effectful transformation.
    /// - Returns: The flatmapped value according to the (deferred) flatMap implementation.
    func flatMap<U>(_ transform: @escaping (T) -> ___FILEBASENAMEASIDENTIFIER___<U>) -> ___FILEBASENAMEASIDENTIFIER___<U>.Coyoneda {
        .init{impl in
            impl.flatMap(chain(impl), transform)
        }
    }
    
    
    ///Applies a series of effectful transformations to the underlying vanilla value.
    /// - Parameters:
    ///     - transform: The series of effectful transformations.
    /// - Returns: The flatmapped value according to the (deferred) flatMap implementation.
    func flatMap<U>(_ transform: @escaping (T) -> ___FILEBASENAMEASIDENTIFIER___<U>.Coyoneda) -> ___FILEBASENAMEASIDENTIFIER___<U>.Coyoneda {
        .init{impl in
            impl.flatMap(chain(impl)){t in
                transform(t).chain(impl)
            }
        }
    }
    
}
