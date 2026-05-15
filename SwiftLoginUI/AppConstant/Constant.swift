//
//  Constant.swift
//  TestLogin
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation

struct AppsNetworkManagerConstants {
    
#if DEBUG
    private static let baseUrl = "https://dummyjson.com/" // test
    private static let mockBaseUrl = "https://fake-json-api.mock.beeceptor.com/" // test
#else
    private static let baseUrl = "https://dummyjson.com/auth" // production
    private static let mockBaseUrl = "https://fake-json-api.mock.beeceptor.com/" // production
#endif
    
    enum Endpoints {
        static let login = "\(AppsNetworkManagerConstants.baseUrl)auth/login"
        static let users = "\(AppsNetworkManagerConstants.baseUrl)users"
        static let userDetail = "\(AppsNetworkManagerConstants.baseUrl)users/%d"
        static let notification = "\(AppsNetworkManagerConstants.mockBaseUrl)notifications"
        static let cart = "\(AppsNetworkManagerConstants.baseUrl)carts"
    }
}

public enum StringConstants {
    
    public enum UserDefaultKeys {
        static let kIsUserLoggedIn      = "isUserLoggedIn"
        static let kLoggedInUsername      = "isUserLoggedIn"
    }
    
    public enum NetworkingManagerConst {
        static let appJson                  = "application/json"
        static let accessToken              = "Authorization"
        static let ContentType              = "Content-Type"
    }
    
    enum HttpMethod: String {
        case get  = "GET"
        case post = "POST"
        case put  = "PUT"
        case delete = "DELETE"
    }
    
    public enum AuthorizationFailedMsg {
        static let serverError               = "Server error. Please try again later."
        static let incorrectAuth             = "Incorrect username or password."
        static let somethingWentWrong        = "Something went wrong. Please try again."
    }
    
    public enum ValidInputdMsg {
        static let emptyUserNme              = "Username cannot be empty"
        static let emptyPassword             = "Password cannot be empty."
        static let passwordLength            = "Password must be at least 6 characters."
    }
    
    public enum Colors {
        static let accent                   = "LaunchAccentColor"
        static let backGround               = "backgroundColor"
        static let backGroundLaunchColor    = "PLaunchBackgroundColor"
    }
    
    public enum ButtonColors {
        static let loginButton          = "loginButtonColor"
    }
    
    public enum ImageName {
        static let loginLogo                = "logo"
        static let passowrdTextfieldImg     = "lock.circle"
        static let emailTextfieldImg        = "person.circle"
        static let leftArrow                = "arrow.left.circle"  // lifecycleImage
        static let lifecycleImage           = "lifecycleImage"  //
    }
    
    public enum FolderNames {
        static let userImages = "user_images"
        static let userDetailImages = "user_detail_image"
    }
}

