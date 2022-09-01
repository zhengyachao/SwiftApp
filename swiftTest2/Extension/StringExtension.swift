//
//  StringExtension.swift


import Foundation
import CommonCrypto
import UIKit
import AVFoundation

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
    //MARK -- URL字符串的编码与解码
    /*
     在我们开发应用的时候都会发送网络请求，如果拼接的 URL 地址中包含有中文、空格、特殊符号时，就会无法正确访问，
     或者打开图片链接也含有中文、空格、特殊符号时也会无法正确访问，这时我们就要对其转义
     */
    /// 编码
    var urlEncoding: String {
        if isEmpty { return "" }
        // 先解码，防止链接二次编码导致链接打不开
        let urlDecod = urlDecoding
        // guard语法的条件为false时执行{}里面的代码
        guard let encodeUrlString = urlDecod.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return self
        }
        return encodeUrlString
    }
    /// 解码
    var urlDecoding: String {
        if isEmpty { return "" }
        // guard语法的条件为false时执行{}里面的代码
        guard let decodingUrl = self.removingPercentEncoding else { return self }
        return decodingUrl
    }
    
    //MARK -- 获取项目名
    public func lh_displayName() ->String{
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    //MARK -- 获取项目版本号
    public func lh_version()->String{
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    //MARK -- 获取系统版本号
    public func lh_iosVersion() ->String{
        return UIDevice.current.systemVersion
    }
    //MARK -- 获取UUID
    public func lh_UUIDString() -> String {
        
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    //MARK -- MD5加密String
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
    func textAutoWidth(height:CGFloat, font:UIFont) ->CGFloat {
        
        let origin = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let lead = NSStringDrawingOptions.usesFontLeading
        
        let rect = self.boundingRect(with:CGSize(width:0, height: height), options: [origin,lead], attributes: [NSAttributedString.Key.font:font], context:nil)
        
        return rect.width
    }
    // String转Double
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    // String转Int
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
    // String转UInt
    func toUInt() -> UInt? {
        return NumberFormatter().number(from: self)?.uintValue
    }
    
    func toNumberFormatString() -> String?{
        return NumberFormatter().number(from: self)?.stringValue
    }
    
    //MARK -- 打开URL
    func openURL() {
        guard let url = URL(string: self) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    ///MARK -- 拨打电话
    func callTelephone() {
        guard let url = URL(string: "telprompt://\(self)") else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    //MARK -- 根据URL获取视频的第一帧图片
    var getVideoFirstFrame: UIImage? {
        guard let videoUrl = URL(string: self) else { return nil }
        
        let asset = AVURLAsset(url: videoUrl, options: nil)
        
        let assetGen = AVAssetImageGenerator(asset: asset)
        
        assetGen.appliesPreferredTrackTransform = true
        
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 1)
        
        do {
            let image = try assetGen.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: image)
        } catch {
            return nil
        }
    }
    
}
