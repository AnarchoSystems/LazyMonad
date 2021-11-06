//___FILEHEADER___

import Foundation


//Your DSL - do whatever you want 


public struct ___VARIABLE_productName___<T> {
 
    public let kind : Kind
    
    fileprivate init(_ kind: Kind){self.kind = kind}
    
    public enum Kind {
        case read((Env) -> T)
        case withState((inout State) -> T)
        case shutdown(() -> T)
    }

}


public struct Env {}

public struct Action {}

public struct State {
    
    mutating func apply(_ action: Action){}
    
}


extension ___VARIABLE_productName___ where T == Env {
    
    static func read() -> Self {
        .init(.read({$0}))
    }
}


extension ___VARIABLE_productName___ where T == Void {
    
    static func withState(_ computeAction: @escaping (State) -> Action) -> Self {
        .init(.withState{state in let action = computeAction(state); state.apply(action)})
    }
    
    static func withState(do action: Action) -> Self {
        withState{_ in action}
    }
    
    static func shutdown() -> Self {
        .init(.shutdown({}))
    }
    
}
