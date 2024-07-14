//
//  AppDelegate.swift
//  EggLife
//
//  Created by 곽서방 on 7/14/24.
//


import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationDelegate = NotificationDelegate()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = notificationDelegate
        requestNotificationAuthorization()
        return true
    }
    
    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification Authorization Error: \(error.localizedDescription)")
            } else {
                // 권한 여부를 UserDefaults에 저장
                DispatchQueue.main.async {
                    UserDefaults.standard.set(granted, forKey: "notificationAuthorizationGranted")
                }
            }
        }
    }
}
