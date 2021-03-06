//___FILEHEADER___

import Foundation



//MARK: DON'T CHANGE


//It shouldn't be necessary to change the below code other than for renaming purposes



public protocol ___VARIABLE_productName___Interpreter {

    associatedtype Val
    
    ///Executes a single instruction of a program.
    /// - Parameters:
    ///     - program: The program.
    /// - Returns: The rest of the program.
    func interpret<T>(_ program: ___VARIABLE_productName___<Val, ___VARIABLE_productName___<Val, T>.Free>) throws -> ___VARIABLE_productName___<Val,T>.Free
}



public extension ___VARIABLE_productName___ {
    
    
    ///The Free data type enables to describe a monadic workflow on the underlying functorial type. In order to run a monadic program, simply write methods for Free that recursively or iteratively switch over the value.
    enum Free {
        case pure(T)
        indirect case free(___VARIABLE_productName___<Val, Free>.Coyoneda)
    }
    
    ///Constructs a new free object.
    /// - Parameters:
    ///     - pure: The pure value to wrap.
    static func free(_ pure: T) -> Free {
        .pure(pure)
    }
    
    ///Constructs a new free object.
    /// - Parameters:
    ///     - impure: The impure value to wrap.
    static func free(_ impure: ___VARIABLE_productName___) -> Free {
        .free(___VARIABLE_productName___.coyoneda(impure).map(Free.pure))
    }
    
}

public extension ___VARIABLE_productName___.Free {
    
    
    typealias ___VARIABLE_productName___U<U> = ___VARIABLE_productName___<Val, U>
    
    
    ///Runs the monadic program given the implementation of map and the interpretation of monadic values.
    /// - Parameters:
    ///     - mapper: The implementation of map.
    ///     - interpreter: The interpreter for the monadic program.
    func runUnsafe<I : ___VARIABLE_productName___Interpreter>
    (mapper: ___VARIABLE_productName___FunctorImplementation,
     interpreter: I) throws -> T where I.Val == Val {
        
        var current = self
        
        while true {
            
            switch current {
            case .pure(let s):
                return s
            case .free(let coyo):
                current = try interpreter
                    .interpret(coyo.runUnsafe(mapper))
            }
            
        }
    }
    
    ///Applies the closure to the wrapped value.
    /// - Parameters:
    ///     - transform: The closure to apply.
    /// - Returns: A transformed free object.
    func map<U>(_ transform: @escaping (T) -> U) -> ___VARIABLE_productName___U<U>.Free {
        switch self {
        case .pure(let s):
            return .pure(transform(s))
        case .free(let ast):
            return .free(ast.map{$0.map(transform)})
        }
    }
    
    ///Applies the effectful closure to the wrapped value.
    /// - Parameters:
    ///     - transform: The effectful closure to apply.
    /// - Returns: A transformed free object carrying the descriptions of new side effects.
    func flatMap<U>(_ transform: @escaping (T) -> ___VARIABLE_productName___U<U>.Free) -> ___VARIABLE_productName___U<U>.Free {
        switch self {
        case .pure(let s):
            return transform(s)
        case .free(let ast):
            return .free(ast.map{$0.flatMap(transform)})
        }
    }
    
    ///Applies the effectful closure to the wrapped value.
    /// - Parameters:
    ///     - transform: The effectful closure to apply.
    /// - Returns: A transformed free object carrying the description of a new side effect.
    func flatMap<U>(_ transform: @escaping (T) -> ___VARIABLE_productName___U<U>) -> ___VARIABLE_productName___U<U>.Free {
        switch self {
        case .pure(let s):
            return .free(___VARIABLE_productName___U<U>.coyoneda(transform(s)).map(___VARIABLE_productName___U<U>.Free.pure))
        case .free(let ast):
            return .free(ast.map{$0.flatMap(transform)})
        }
    }
    
}


