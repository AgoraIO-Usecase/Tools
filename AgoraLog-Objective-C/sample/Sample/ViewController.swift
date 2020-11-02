//
//  ViewController.swift
//  Sample
//
//  Created by CavanSu on 2020/10/27.
//  Copyright © 2020 CavanSu. All rights reserved.
//

import UIKit
import AgoraLog

class ViewController: UIViewController {
    var log1: AgoraLogger!
    var log2: AgoraLogger!
    var log3: AgoraLogger!
    var log4: AgoraLogger!
    var log5: AgoraLogger!
    var log6: AgoraLogger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documents = NSHomeDirectory() + "/Test"
        print("documents: \(documents)")
        
        let folder1 = documents + "/LogFolder1"
        let folder2 = documents + "/LogFolder2"
        let folder3 = documents + "/LogFolder3"
        let folder4 = documents + "/LogFolder4"
        let folder5 = documents + "/LogFolder5"
        
        let prefix1 = "Test1"
        let prefix2 = "Test2"
        let prefix3 = "Test3"
        let prefix4 = "Test4"
        let prefix5 = "Test5"
        
        log1 = AgoraLogger(folderPath: folder1,
                           filePrefix: prefix1,
                           maximumNumberOfFiles: 1)
        
        log2 = AgoraLogger(folderPath: folder2,
                           filePrefix: prefix2,
                           maximumNumberOfFiles: 2)
        
        log3 = AgoraLogger(folderPath: folder3,
                           filePrefix: prefix3,
                           maximumNumberOfFiles: 3)
        
        log4 = AgoraLogger(folderPath: folder4,
                           filePrefix: prefix4,
                           maximumNumberOfFiles: 4)
        
        log5 = AgoraLogger(folderPath: folder5,
                           filePrefix: prefix5,
                           maximumNumberOfFiles: 5)
        
        log1.setPrintOnConsoleType(.all)
        log2.setPrintOnConsoleType(.info)
        log3.setPrintOnConsoleType(.warning)
        log4.setPrintOnConsoleType(.error)
        log5.setPrintOnConsoleType(.none)
        
        print("----------------------------------------------")
        
        log1.log("test1 info", type: .info)
        log1.log("test1 warning", type: .warning)
        log1.log("test1 error", type: .error)
        
        print("----------------------------------------------")
        
        log2.log("test2 info", type: .info)
        log2.log("test2 warning", type: .warning)
        log2.log("test2 error", type: .error)
        
        print("----------------------------------------------")
        
        log3.log("test3 info", type: .info)
        log3.log("test3 warning", type: .warning)
        log3.log("test3 error", type: .error)
        
        print("----------------------------------------------")
        
        log4.log("test4 info", type: .info)
        log4.log("test4 warning", type: .warning)
        log4.log("test4 error", type: .error)
        
        print("----------------------------------------------")
        
        log5.log("test5 info", type: .info)
        log5.log("test5 warning", type: .warning)
        log5.log("test5 error", type: .error)
        
        print("----------------------------------------------")
        
        let folder6 = folder1
        let prefix6 = "Test6"
        
        log6 = AgoraLogger(folderPath: folder6,
                           filePrefix: prefix6,
                           maximumNumberOfFiles: 5)
        
        log6.setPrintOnConsoleType(.all)
        
        log6.log("test6 info", type: .info)
        log6.log("test6 warning", type: .warning)
        log6.log("test6 error", type: .error)
        
        print("----------------------------------------------")
        
        print("Test end")
    }
}

