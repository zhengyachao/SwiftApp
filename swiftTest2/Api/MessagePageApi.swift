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
    case getNewsTypes
    case getNewsList(typeId:String,page:Int)
    case getNewsDetails(newsId:String)
    case getGirlList(page: Int)
}

extension MessagePageApi: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        
        return URL(string: kBaseUrl)!
    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        switch self {
        case .getDaily_wordRecommend(_, _, _):
            return kDaily_wordRecommend
        case .getNewsTypes:
            return kNewsTypes
        case .getNewsList(_, _):
            return kNewsList
        case .getNewsDetails(_):
            return kNewsDetails
        case .getGirlList(_):
            return kGirlList
        }
    }

    /// The HTTP method used in the request.
    var method: Moya.Method {
            return .get
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        // 初始化字典
        var parmeters : [String : Any] = Dictionary()
        
        switch self {
        case .getDaily_wordRecommend(let count, let app_id, let app_secret):
            parmeters["count"] = count
            parmeters["app_id"] = app_id
            parmeters["app_secret"] = app_secret
            
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .getNewsTypes:
            parmeters["app_id"]     = kAppId
            parmeters["app_secret"] = kAppSecret
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
            
        case .getNewsList(let typeId, let page):
            parmeters["typeId"]     = typeId
            parmeters["page"]       = page
            parmeters["app_id"]     = kAppId
            parmeters["app_secret"] = kAppSecret
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
            
        case .getNewsDetails(let newsId):
            parmeters["newsId"]     = newsId
            parmeters["app_id"]     = kAppId
            parmeters["app_secret"] = kAppSecret
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
            
        case .getGirlList(let page):
            parmeters["page"]       = page
            parmeters["app_id"]     = kAppId
            parmeters["app_secret"] = kAppSecret
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    }

    /// The headers to be used in the request.
    var headers: [String: String]? {
        return nil
    }
}
