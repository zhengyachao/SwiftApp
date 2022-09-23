//
//  HomeAppListApi.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/18.
//

/*
 Provider：provider是一个提供网络请求服务的提供者。通过一些初始化配置之后，在外部可以直接用provider来发起request。
 Request：在使用Moya进行网络请求时，第一步需要进行配置，来生成一个Request。首先按照官方文档，创建一个枚举，遵守TargetType协议，并实现协议所规定的属性。为什么要创建枚举来遵守协议，枚举结合switch语句，使得API管理起来比较方便。
 根据创建了一个遵守TargetType协议的名为Myservice的枚举，我们完成了如下几个变量的设置。
 */

import UIKit
import Moya

//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                  in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

let homeProvider = MoyaProvider<HomeAppListApi>()

enum HomeAppListApi {
    case findRecruitmentDataPage(majorId:Int)
    
    case downloadTestApi
}

extension HomeAppListApi:  TargetType {
    var baseURL: URL {
        switch self {
        case .findRecruitmentDataPage(_):
            return URL(string: "http://iservice.bjyijie.com.cn/")!
        case .downloadTestApi:
//            return URL(string: "https://v-cdn.zjol.com.cn/")!
            return URL(string: "https://tvax2.sinaimg.cn/large/005BYqpggy1g3jskzyvifj31900u00xo.jpg")!
        }
    }
    
    var path: String {
        switch self {
        case .findRecruitmentDataPage(_):
            return "studentUser/getJudgeMajorType"
        case.downloadTestApi:
//            return "280443.mp4"
            return ""
        }
    }
    
    // 请求类型
    var method: Moya.Method {
        switch self {
        case .findRecruitmentDataPage(_):
            return .get
        case .downloadTestApi:
            return .get
        }
    }
    // 请求任务事件（这里附带上参数）
    var task: Task {
        var parmeters: [String : Any] = [:]
        
        switch self {
        case .findRecruitmentDataPage(let majorId):
            
            parmeters["majorId"] = majorId
            print("当前接口parmeters为\(parmeters)")
            if self.method == .post {
                return .requestCompositeParameters(bodyParameters: parmeters, bodyEncoding: JSONEncoding.default, urlParameters: [:])
            }
            
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
            
        case .downloadTestApi:
        
            return .downloadDestination { temporaryURL, response in
                
                return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), .removePreviousFile)
            }        
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
