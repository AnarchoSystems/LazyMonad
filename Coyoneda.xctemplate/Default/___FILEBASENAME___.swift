//___FILEHEADER___

import Foundation


//Your DSL -- change as you see fit


public struct ___VARIABLE_productName___<T> {
    
    public let kind : Kind
    
    fileprivate init(kind: Kind){
        self.kind = kind
    }
    
    public enum Kind {
        case photos(PhotoRequest, ([Photo]) -> T)
        case profile(UserProfileRequest, (UserProfile) -> T)
        case writings(WritingsRequest, ([Writing]) -> T)
    }
    
}

public extension ___VARIABLE_productName___ where T == [Photo] {
    static func photos(_ request: PhotoRequest) -> Self {
        ___VARIABLE_productName___(kind: Kind.photos(request){$0})
    }
}

public extension ___VARIABLE_productName___ where T == [Writing] {
    static func photos(_ request: WritingsRequest) -> Self {
        ___VARIABLE_productName___(kind: Kind.writings(request){$0})
    }
}

public extension ___VARIABLE_productName___ where T == UserProfile {
    static func profile(_ request: UserProfileRequest) -> Self {
        ___VARIABLE_productName___(kind: Kind.profile(request){$0})
    }
}

public struct PhotoRequest{}
public struct UserProfileRequest{}
public struct WritingsRequest{}

public struct Photo{}
public struct UserProfile{}
public struct Writing{}
