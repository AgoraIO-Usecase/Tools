//
//  ViewController.swift
//  Sample
//
//  Created by Cavan on 2021/3/9.
//

import UIKit
import AgoraSceneStatistic

class ViewController: UIViewController {
    var service: AgoraSceneStatistic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = AgoraSceneStatistic()
        
        let values = [AgoraUserRatingValue(type: .callQuality, value: 5),
                      AgoraUserRatingValue(type: .functionCompleteness, value: 5),
                      AgoraUserRatingValue(type: .generalExperience, value: 5)]
        
        service.context = AgoraSceneStatisticContext()
        service.context.os = "ios"
        service.context.device = "simulator"
        service.context.app = "sample"
        service.context.useCase = "meeting"
        service.context.userId = "testUserId"
        service.context.sessionId = "testSessionId"
        
        service.userRating(values,
                           comment: "testComment") {
            print("success")
        } fail: { (code) in
            print("error: \(code)")
        }
    }
}

