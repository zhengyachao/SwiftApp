//
//  StringExtension.swift


import Foundation
import CommonCrypto
import UIKit

extension String {
    
    func subString(r:Range<Int>)->String{
        let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func subString(index:Int , length:Int) -> String{
        let startIndex = self.index(self.startIndex, offsetBy: index)
        let endIndex = self.index(startIndex, offsetBy: length)
        return String(self[startIndex..<endIndex])
    }
    
    public func lh_displayName() ->String{
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    public func lh_version()->String{
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public func lh_iosVersion() ->String{
        return UIDevice.current.systemVersion
    }
    
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        return hash as String
    }
    ///根据宽度跟字体，计算文字的高度
    func textAutoHeight(width:CGFloat, font:UIFont) ->CGFloat{
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let lead = NSStringDrawingOptions.usesFontLeading
        
        let ssss = NSStringDrawingOptions.usesDeviceMetrics
        
        let rect = self.boundingRect(with:CGSize(width: width, height:0), options: [origin,lead,ssss], attributes: [NSAttributedString.Key.font:font], context:nil)
        
        return rect.height
        
        }
    
    ///根据高度跟字体，计算文字的宽度
    
    func textAutoWidth(height:CGFloat, font:UIFont) ->CGFloat{
        
        
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let lead = NSStringDrawingOptions.usesFontLeading
        
        let rect = self.boundingRect(with:CGSize(width:0, height: height), options: [origin,lead], attributes: [NSAttributedString.Key.font:font], context:nil)
        
        return rect.width
        
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
    
    func toUInt() -> UInt? {
        return NumberFormatter().number(from: self)?.uintValue
    }
    
    func toNumberFormatString() -> String?{
        return NumberFormatter().number(from: self)?.stringValue
    }
}
