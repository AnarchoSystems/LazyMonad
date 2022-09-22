//___FILEHEADER___

import Foundation


//Your DSL - do whatever you want 


public struct ___VARIABLE_productName___<T> {
 
    public let kind : Kind
    
    fileprivate init(_ kind: Kind){self.kind = kind}
    
    public enum Kind {
        case read((Env) -> T)
        case handle((State) -> Action, () -> T)
        case apiRequest(APIRequest, (APIResponse) -> T)
        case error(InternalError, (ErrorRecovery) -> T)
    }
    
    public func erased() -> ___VARIABLE_productName___<Any> {
        switch kind {
        case .read(let reader):
            return .init(.read(reader))
        case .handle(let computeAction, let handle):
            return .init(.handle(computeAction, handle))
        case .apiRequest(let req, let onResponse):
            return .init(.apiRequest(req, onResponse))
        case .error(let error, let recover):
            return .init(.error(error, recover))
        }
    }

}


public struct Env {}

public struct Action {}

public struct APIRequest {}

public struct APIResponse {}

public struct InternalError {}

public struct ErrorRecovery {}

public struct State {
    
    mutating func apply(_ action: Action){}
    
}

public extension ___VARIABLE_productName___.Free where T == Env {
    
    static func read() -> Self {
        .lift(.init(.read({$0})))
    }
}


public extension ___VARIABLE_productName___.Free where T == Void {
    
    static func withState(_ computeAction: @escaping (State) -> Action) -> Self {
        .lift(.init(.handle(computeAction, {})))
    }
    
    static func withState(do action: Action) -> Self {
        withState{_ in action}
    }
    
}

public extension ___VARIABLE_productName___.Free where T == APIResponse {
 
    static func request(_ req: APIRequest) -> Self {
        .lift(.init(.apiRequest(req, {$0})))
    }
    
}

public extension ___VARIABLE_productName___.Free where T == ErrorRecovery {
    
    static func fail(_ error: InternalError) -> Self {
        .lift(.init(.error(error, {$0})))
    }
    
}
