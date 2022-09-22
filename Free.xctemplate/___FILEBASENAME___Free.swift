//___FILEHEADER___

import Foundation


///Responsible for actually running the ___VARIABLE_productName___ monad. This interpreter type assumes a safe and stateless run.
public protocol ___VARIABLE_productName___Interpreter {
    
    ///Assigns a meaning to the ___VARIABLE_productName___ in a stateless, safe and pure way.
    /// - Parameters:
    ///     - action: The ___VARIABLE_productName___ to receive a meaning.
    ///     - continuation: The rest of the workflow.
    func evaluate<T>(_ action: ___VARIABLE_productName___<T>) -> T
    
}

public extension ___VARIABLE_productName___ {
    
    ///Free lazily turns your ___VARIABLE_productName___ into a monad for free!
    ///You can lift plain values into the monad via the static ```pure```, but you can also "throw" ___VARIABLE_productName___s via the static method ```lift```. The methods ```map``` and ```flatMap``` enable you to chain pure workflows and workflows "throwing" ___VARIABLE_productName___s. It is good practice to use ```lift``` to define "smart constructors" that you can use in your ```flatMap```s.
    ///Later on, you can assign a meaning to your ___VARIABLE_productName___ by implementing an interpreter and passing it to ```runUnsafe```.
    struct Free {
        
        //Should help to make refactorization of the number of generic types a little bit more convenient
        public typealias ___VARIABLE_productName___U<U> = ___VARIABLE_productName___<U>
        
        fileprivate enum Kind {
            case pure(T)
            case free(___VARIABLE_productName___U<Any>, (Any) -> Free)
        }
        
        fileprivate let kind : Kind
        
        public static func pure(_ t: T) -> Self {
            .init(kind: .pure(t))
        }
        
        fileprivate static func free(_ interp: ___VARIABLE_productName___U<Any>, cont: @escaping (Any) -> Self) -> Self {
            .init(kind: .free(interp, cont))
        }
        
        ///Transforms the result of the monadic computation in a pure way.
        /// - Parameters:
        ///     - transform: The pure transformation to apply to the computation result.
        public func map<S>(_ transform: @escaping (T) -> S) -> ___VARIABLE_productName___U<S>.Free{
            switch kind {
            case .pure(let t):
                return .pure(transform(t))
            case .free(let i, let cont):
                return .free(i){cont($0).map(transform)}
            }
        }
        
        ///Transforms the result of the monadic computation with an impure closure.
        /// - Parameters:
        ///     - transform: The closure "throwing" ___VARIABLE_productName___s.
        public func flatMap<S>(_ transform: @escaping (T) -> ___VARIABLE_productName___U<S>.Free) -> ___VARIABLE_productName___U<S>.Free{
            switch kind {
            case .pure(let t):
                return transform(t)
            case .free(let i, let cont):
                return .free(i){t in cont(t).flatMap(transform)}
            }
        }
        
        ///Runs the monadic computation using a pure, stateless and safe interpreter.
        /// - Note: The implementation of ```runUnsafe``` is exactly the same for different types of interpreters. Feel free to add further target monads via copy+paste. If Swift had higher kind types, one could even put this into a single protocol.
        public func runUnsafe<I : ___VARIABLE_productName___Interpreter>(_ interpreter: I) -> T {
            
            var current = self.kind
            
            while true {
                switch current {
                case .pure(let t):
                    return t
                case .free(let i, let cont):
                    current = cont(interpreter.evaluate(i)).kind
                }
            }
            
        }
        
        ///Runs the monadic computation using an interpreter appropriate for testing and debugging.
        /// - Note: The implementation of ```runUnsafe``` is exactly the same for different types of interpreters. Feel free to add further target monads via copy+paste. If Swift had higher kind types, one could even put this into a single protocol.
        public func runUnsafe<I : ___VARIABLE_productName___MockInterpreter>(_ interpreter: I) -> ___VARIABLE_productName___MockMonad<T> {
            
            switch kind {
            case .pure(let t):
                return .pure(t)
            case .free(let i, let cont):
                return interpreter.evaluate(i).flatMap{cont($0).runUnsafe(interpreter)}
                }
            }
            
        ///Runs the monadic computation using an interpreter appropriate for production.
        /// - Note: The implementation of ```runUnsafe``` is exactly the same for different types of interpreters. Feel free to add further target monads via copy+paste. If Swift had higher kind types, one could even put this into a single protocol.
        public func runUnsafe<I : ___VARIABLE_productName___TargetInterpreter>(_ interpreter: I) -> ___VARIABLE_productName___TargetMonad<T> {
            
            switch kind {
            case .pure(let t):
                return .pure(t)
            case .free(let i, let cont):
                return interpreter.evaluate(i).flatMap{cont($0).runUnsafe(interpreter)}
            }
        }
        
        
        ///Wraps a ___VARIABLE_productName___ into the monad.
        /// - Parameters:
        ///     - action: The ___VARIABLE_productName___ to wrap.
        public static func lift(_ action: ___VARIABLE_productName___) -> Free {
            .init(kind: .free(action.erased(), {.pure($0 as! T)}))
        }
        
    }
    
}
