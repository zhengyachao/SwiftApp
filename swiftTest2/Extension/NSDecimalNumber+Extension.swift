//
//  NSDecimalNumber+Extension.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/1.
//

import Foundation

extension NSDecimalNumber {
    /*
     直接使用+、-、*、/
     let sum = decimalNumber1 + decimalNumber2
     let subtracting = decimalNumber1 - decimalNumber2
     let multiplying = decimalNumber1 * decimalNumber2
     let dividing = decimalNumber1 / decimalNumber2
     */
    //MARK -- NSDecimalNumber添加四个扩展+、-、*、/
    static func + (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.adding(rhs)
    }
    
    static func - (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.subtracting(rhs)
    }
    
    static func * (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.multiplying(by: rhs)
    }
    
    static func / (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.dividing(by: rhs)
    }
    
    /// 转String 四舍五入
    /// - Parameter scale: 保留几位小数
    /// - Parameter roundingMode:
    ///     plain: 保留位数的下一位四舍五入
    ///     down: 保留位数的下一位直接舍去
    ///     up: 保留位数的下一位直接进一位
    ///     bankers: 当保留位数的下一位不是5时，四舍五入，当保留位数的下一位是5时，其前一位是偶数直接舍去，是奇数直接进位（如果5后面还有数字则直接进位）
    func toString(_ scale: Int = 2,
                  roundingMode: RoundingMode = .plain) -> String {
        let behavior = NSDecimalNumberHandler(
            roundingMode: roundingMode,
            scale: Int16(scale),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: true)
        let product = multiplying(by: .one, withBehavior: behavior)
        return product.stringValue
    }
}
