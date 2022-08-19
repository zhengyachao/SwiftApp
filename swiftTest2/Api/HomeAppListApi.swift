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
    case findRecruitmentDataPage(majorId:Int)
}

extension HomeAppListApi:  TargetType {
    var baseURL: URL {
        switch self {
        case .findRecruitmentDataPage(_):
            return URL(string: "http://iservice.bjyijie.com.cn/")!
        }
    }
    
    var path: String {
        switch self {
        case .findRecruitmentDataPage(_):
            return "studentUser/getJudgeMajorType"
        }
    }
    
    // 请求类型
    var method: Moya.Method {
        switch self {
        case .findRecruitmentDataPage(_):
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
