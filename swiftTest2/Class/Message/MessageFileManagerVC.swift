//
//  MessageFileManagerVC.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/2.
//

import UIKit

class MessageFileManagerVC: YCBaseViewController {
    
    var isWrite  = false
    var isDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "文件管理"
        initFileManager()
    }
    
    func initFileManager () {
        let foldPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String + "/TestFold"
        
        let filePath = foldPath + "/test.txt"
        // 判断文件test.txt是否存在
        let isExit = kFileManager.fileExists(atPath: filePath)
        if !isExit {
            kFileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
    
        let testStr = "jadjsaksdadsak"
        /*
         do {
               try   //throw error语句
               //没有错误发生时的后续语句
         }catch {
             //错误处理语句
         }
         */
        try? testStr.write(toFile: filePath, atomically: true, encoding: .utf8)
        do {
            // 写入内容
            try testStr.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch  {
            
        }
        
        // 删除文件
        let testFilePath = foldPath + "/testFile"
        
        do {
            if kFileManager.fileExists(atPath: testFilePath) {
                try kFileManager.removeItem(atPath: testFilePath)
            }
        } catch  {
            
        }
    }
    
}
