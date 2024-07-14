//
//  NotificationService.swift
//  EggLife
//
//  Created by 곽서방 on 7/14/24.
//

import UserNotifications

struct NotificationService {
    
    func sendNotification() {
        let granted = UserDefaults.standard.bool(forKey: "notificationAuthorizationGranted")
        guard granted else {
            print("Notification permission not granted.")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "타이머 종료!"
        content.body = "설정한 타이머가 종료되었습니다."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: \(error.localizedDescription)")
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}

