//
//  MoyaConfig.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/8/29.
//

import Foundation

let kBaseUrl   = "https://www.mxnzp.com/api/"

let kAppId     = "1gggxzoqoamfmpsu"
let kAppSecret = "cWkxSm9VYzkwd3BTRG8xK3BvSGIxUT09"


//MARK: -- 每日一句Path
let kDaily_wordRecommend = "daily_word/recommend"

//MARK: -- 新闻接口Path
let kNewsTypes   = "news/types"   // 获取所有新闻类型列表
let kNewsList    = "news/list"    // 根据新闻类型获取新闻列表
let kNewsDetails = "news/details" // 根据新闻id获取新闻详情

//MARK: -- 获取福利图片列表
let kGirlList    = "image/girl/list/random"

//MARK: -- 获取食物的分类列表
let kFoodHeatTypeList = "food_heat/type/list" // 获取食物的分类列表
let kFoodHeatFoodList = "food_heat/food/list" // 获取分类下的食物列表
