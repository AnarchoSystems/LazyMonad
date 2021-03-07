//___FILEHEADER___

import Foundation


///Responsible for actually running the ___VARIABLE_productName___ monad. This interpreter type assumes a safe and stateless run.
public protocol ActionInterpreter {
    
    ///Assigns a meaning to the ___VARIABLE_productName___ in a stateless, safe and pure way.
    /// - Parameters:
    ///     - action: The ___VARIABLE_productName___ to receive a meaning.
    ///     - continuation: The rest of the workflow.
    func evaluate<S,T>(_ action: ___VARIABLE_productName___<S>, continuation: (S) -> T) -> T

}


public extension ___VARIABLE_productName___ {
    
    ///Free lazily turns your ___VARIABLE_productName___ into a monad for free!
    ///You can lift plain values into the monad via the static ```pure```, but you can also "throw" ___VARIABLE_productName___s via the static method ```lift```. The methods ```map``` and ```flatMap``` enable you to chain pure workflows and workflows "throwing" ___VARIABLE_productName___s. It is good practice to use ```lift``` to define "smart constructors" that you can use in your ```flatMap```s.
    ///Later on, you can assign a meaning to your ___VARIABLE_productName___ by implementing an interpreter and passing it to ```runUnsafe```.
    class Free {
        
        //Should help to make refactorization of the number of generic types a little bit more convenient
        public typealias ___VARIABLE_productName___U<U> = ___VARIABLE_productName___<U>
        
        ///In absence of sealed classes, making only initializer fileprivate is the best way to effectively prevent uncontrolled subclassing, as you cannot initialize subclasses declared outside this file.
        fileprivate init(){}
        
        ///Transforms the result of the monadic computation in a pure way.
        /// - Parameters:
        ///     - transform: The pure transformation to apply to the computation result.
        public func map<S>(_ transform: @escaping (T) -> S) -> ___VARIABLE_productName___U<S>.Free{
            fatalError("Abstract")
        }
        
        ///Transforms the result of the monadic computation with an impure closure.
        /// - Parameters:
        ///     - transform: The closure "throwing" ___VARIABLE_productName___s.
        public func flatMap<S>(_ transform: @escaping (T) -> ___VARIABLE_productName___U<S>.Free) -> ___VARIABLE_productName___U<S>.Free{
            fatalError("Abstract")
        }
        
        ///Runs the monadic computation using a pure, stateless and safe interpreter.
        /// - Note: The implementation of ```runUnsafe``` is exactly the same for different types of interpreters. Feel free to add further target monads via copy+paste. If Swift had higher kind types, one could even put this into a single protocol.
        public func runUnsafe<I : ActionInterpreter>(_ interpreter: I) -> T {
            fatalError("Abstract")
        }
        
        ///Runs the monadic computation using an interpreter appropriate for testing and debugging.
        /// - Note: The implementation of ```runUnsafe``` is exactly the same for different types of interpreters. Feel free to add further target monads via copy+paste. If Swift had higher kind types, one could even put this into a single protocol.
        public func runUnsafe<I : ___VARIABLE_productName___MockInterpreter>(_ interpreter: I) -> ___VARIABLE_productName___MockMonad<T> {
            fatalError("Abstract")
        }
        
        ///Runs the monadic computation using an interpreter appropriate for production.
        /// - Note: The implementation of ```runUnsafe``` is exactly the same for different types of interpreters. Feel free to add further target monads via copy+paste. If Swift had higher kind types, one could even put this into a single protocol.
        public func runUnsafe<I : ___VARIABLE_productName___TargetInterpreter>(_ interpreter: I) -> ___VARIABLE_productName___TargetMonad<T> {
            fatalError("Abstract")
        }
        
        ///Wraps a pure value into the monad.
        /// - Parameters:
        ///     - t: The value to wrap.
        static func pure(_ t: T) -> Free {
            Pure(base: t)
        }
        
        ///Wraps a ___VARIABLE_productName___ onto the monad.
        /// - Parameters:
        ///     - action: The ___Variable_productName___ to wrap.
        static func lift(_ action: ___VARIABLE_productName___) -> Free {
            FlatMap(base: action,
                    continuation: pure)
        }
        
    }
    
}


fileprivate extension ___VARIABLE_productName___ {
    
    final class Pure : Free {
        let base : T
        init(base: T){
            self.base = base
        }
        override func map<S>(_ transform: @escaping (T) -> S) -> ___VARIABLE_productName___U<S>.Free{
            ___VARIABLE_productName___U<S>.Pure(base: transform(base))
        }
        override func flatMap<S>(_ transform: @escaping (T) -> ___VARIABLE_productName___U<S>.Free) -> ___VARIABLE_productName___U<S>.Free{
            transform(base)
        }
        override func runUnsafe<I : ActionInterpreter>(_ interp: I) -> T {
            base
        }
        override func runUnsafe<I : ___VARIABLE_productName___TargetInterpreter>(_ interp: I) -> ___VARIABLE_productName___TargetMonad<T> {
            .pure(base)
        }
        override func runUnsafe<I : ___VARIABLE_productName___MockInterpreter>(_ interp: I) -> ___VARIABLE_productName___MockMonad<T> {
            .pure(base)
        }
    }
    
    final class FlatMap<U> : Free {
        let base : ___VARIABLE_productName___U<U>
        let continuation : (U) -> ___VARIABLE_productName___<T>.Free
        init(base: ___VARIABLE_productName___U<U>, continuation: @escaping (U) -> ___VARIABLE_productName___<T>.Free){
            self.base = base
            self.continuation = continuation
        }
        override func map<S>(_ transform: @escaping (T) -> S) -> ___VARIABLE_productName___U<S>.Free {
            let continuation = self.continuation
            return ___VARIABLE_productName___U<S>.FlatMap(base: base){a in continuation(a).map(transform)}
        }
        override func flatMap<S>(_ transform: @escaping (T) -> ___VARIABLE_productName___U<S>.Free) -> ___VARIABLE_productName___U<S>.Free {
            let continuation = self.continuation
            return ___VARIABLE_productName___U<S>.FlatMap(base: base){a in continuation(a).flatMap(transform)}
        }
        override func runUnsafe<I : ActionInterpreter>(_ interp: I) -> T {
            let continuation = self.continuation
            return interp.evaluate(base){u in continuation(u).runUnsafe(interp)}
        }
        override func runUnsafe<I : ___VARIABLE_productName___TargetInterpreter>(_ interp: I) -> ___VARIABLE_productName___TargetMonad<T> {
            let continuation = self.continuation
            return interp.interpret(base){u in continuation(u).runUnsafe(interp)}
        }
        override func runUnsafe<I : ___VARIABLE_productName___MockInterpreter>(_ interp: I) -> ___VARIABLE_productName___MockMonad<T> {
            let continuation = self.continuation
            return interp.interpret(base){u in continuation(u).runUnsafe(interp)}
        }
    }
    
}
