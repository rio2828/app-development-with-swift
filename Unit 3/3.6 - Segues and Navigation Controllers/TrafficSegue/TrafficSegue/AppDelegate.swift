//
//  AppDelegate.swift
//  TrafficSegue
//
//  Created by 김태현 on 2022/07/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//안녕하세요 조교님들, 현재 iOS 앱만들기 Part 1의 "Segues and Navigation Controllers"를 수강하고 있는데 질문이 생겨 문의드립니다. [빨강 -> 노랑 -> 초록] 과 같이 Segue를 이용하여 View들간 이동을 하는데, 제가 이해한 바로는 Unwind 함수는 되돌아가고 싶은 뷰 안에 선언하는 것으로 알고있습니다. 가령, 노랑과 초록 View에서 빨강 View로 되돌아가는 경우는 빨강 View 안에 Unwind 함수를 선언하고, 초록 View 에서 노랑 View로 되돌아가는 경우는 노랑 View 안에 함수를 선언하는 것으로 이해했습니다. 혹시 제가 이해한 내용이 맞는지 궁금합니다. 또한 강의 내에서 직접 해보라고 하신 프로젝트는 어디로 제출해야 리뷰가 가능할까요? 감사합니다!

