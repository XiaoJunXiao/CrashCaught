//
//  UncaughtExceptionHandlerHelper.swift
//  CrashCaught
//
//  Created by Xiao on 2019/12/11.
//  Copyright © 2019 Xiao. All rights reserved.
//

import UIKit

class UncaughtExceptionHandlerHelper: NSObject {
    class func UncaughtExceptionHandler(exception:NSException){
        let name = exception.name
        // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
        let reason = exception.reason
        //详情
        let arr = exception.callStackSymbols as NSArray
        //当前app版本
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        //当前设备
        let deviceModel = UIDevice.current.model
        //系统版本
        let sysVersion = UIDevice.current.systemVersion
        //崩溃报告的格式，可以自己重新写
        let crashText = "App Version:\(currentVersion!)\nVersion:\(sysVersion)\nVerdor:\(deviceModel)\nname:\(name)\nreason:\n\(reason)\ncallStackSymbols:\n\(arr.componentsJoined(by: "\n"))"
        print(crashText)
        //保存路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/Exception.txt"
        // 将txt文件写入沙盒
        do{
            try crashText.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        }catch{
           print(error)
        }
    }
    
    class func setDefaultHandler(){
        NSSetUncaughtExceptionHandler { (exception) in
            UncaughtExceptionHandlerHelper.UncaughtExceptionHandler(exception: exception)
        }
    }
    
    class func getHandler()->NSUncaughtExceptionHandler{
        return NSGetUncaughtExceptionHandler()!
    }
}
