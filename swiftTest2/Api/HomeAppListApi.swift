//
//  HomeAppListApi.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/18.
//

import UIKit
import Moya

let homeProvider = MoyaProvider<HomeAppListApi>()

enum HomeAppListApi {
    
    case realtimeWeather(cityId:String)
}

extension HomeAppListApi:  TargetType {
    var baseURL: URL {
        switch self {
        case .realtimeWeather(_):
            /*http://weatherapi.market.xiaomi.com/wtr-v2/weather?cityId=101110101&imei=e32c8a29d0e8633283737f5d9f381d47&device=HM2013023&miuiVersion=JHBCNBD16.0&modDevice=&source=miuiWeatherApp*/
            return URL(string: "http://weatherapi.market.xiaomi.com/wtr-v2/weather")!
        }
    }
    
    var path: String {
        switch self {
        case .realtimeWeather(_):
            return ""
        }
    }
    
    // 请求类型
    var method: Moya.Method {
        switch self {
        case .realtimeWeather(_):
            return .get
        }
    }
    // 请求任务事件（这里附带上参数）
    var task: Task {
        var parmeters: [String : Any] = [:]
        
        switch self {
        case .realtimeWeather(let cityId):
            print("cityId----",cityId)
//            cityId=101110101&imei=e32c8a29d0e8633283737f5d9f381d47&device=HM2013023&miuiVersion=JHBCNBD16.0&modDevice=&source=miuiWeatherApp
            parmeters = ["cityId":cityId,
                         "imei":"e32c8a29d0e8633283737f5d9f381d47",
                         "device":"HM2013023",
                         "miuiVersion":"JHBCNBD16.0",
                         "modDevice": "",
                         "source":"miuiWeatherApp"
                        ] as [String : Any]
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    }
    
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    // 请求头
    var headers: [String : String]? {
        return nil
    }
}
