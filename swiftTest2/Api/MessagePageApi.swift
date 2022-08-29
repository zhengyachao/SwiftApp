//
//  MessagePageApi.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import UIKit
import Moya

let messageProvider = MoyaProvider<MessagePageApi>()

enum MessagePageApi {

    case getDaily_wordRecommend(count:Int,app_id:String,app_secret:String)
}

extension MessagePageApi: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        switch self {
        case .getDaily_wordRecommend(_, _, _):
            return URL(string: kBaseUrl)!
        }       
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getDaily_wordRecommend(_, _, _):
            
            return kDaily_wordRecommend
        }
    }

    /// The HTTP method used in the request.
    var method: Moya.Method {
    
        switch self {
        case .getDaily_wordRecommend(_, _, _):
            return .get
        }
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        
        switch self {
        case .getDaily_wordRecommend(let count, let app_id, let app_secret):
            // 初始化字典
            var parmeters : [String : Any] = Dictionary()
            
            parmeters["count"] = count
            parmeters["app_id"] = app_id
            parmeters["app_secret"] = app_secret
            
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    }

    /// The headers to be used in the request.
    var headers: [String: String]? {
        return nil
    }
}
