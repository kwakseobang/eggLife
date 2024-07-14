//
//  TimerViewModel.swift
//  EggLife
//
//  Created by 곽서방 on 7/9/24.
//

import Foundation
import Combine
import SwiftUI

enum mode {
    case isAction
    case isStop
    
}
enum eggType {
    case soft
    case hard
}

class TimerViewModel: ObservableObject {
    @Published var mode: mode = .isStop
    @Published var softEggTime: Time =  .init(minutes: 10, seconds: 0)
    @Published var hardEggTime: Time =  .init(minutes: 12, seconds: 0)
    @Published var timeRemaining: Int = 0
    @Published var eggType: eggType = .soft
    @Published var goToSetTimer: Bool = false
    
    private var cancellable: AnyCancellable?
    var notificationService: NotificationService = .init()
    
}

extension TimerViewModel {
    
    //Timer Setting
    func timerSettingBtnTapped() {
        goToSetTimer = false
        if eggType == .soft {
            self.timeRemaining = softEggTime.convertedSeconds
        } else {
            self.timeRemaining = hardEggTime.convertedSeconds
        }
    }
    
    // stop
    func initBtnTapped() {
        self.stopTimer()
        self.mode = .isStop
        self.resetTimer()
    }
    
    //재시작 및  일시정지
    func startOrPauseBtnTapped() {
        // if 시작 else 일시정지
        if mode == .isStop {
            self.startTimer()
            self.mode = .isAction
        } else {
            self.stopTimer()
            self.mode = .isStop
        }
    }
    
}

private extension TimerViewModel {
    //start
    func startTimer() {
        guard cancellable == nil else {return} //nil이어야 설정
        
        var backgroundTaskID: UIBackgroundTaskIdentifier?
        backgroundTaskID = UIApplication.shared.beginBackgroundTask {
            if let task = backgroundTaskID {
                UIApplication.shared.endBackgroundTask(task)
                backgroundTaskID = .invalid
            }
        }
        
        // 경과 부분
        self.cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                    self.notificationService.sendNotification()
                }
            }
            )
    }
    
    
    //stop
    func stopTimer() {
        self.cancellable?.cancel()
        self.cancellable = nil
    }
    
    //reset
    func resetTimer() {
        //        self.timeRemaining = time.convertedSeconds
        if eggType == .soft {
            self.timeRemaining = softEggTime.convertedSeconds
        } else {
            self.timeRemaining = hardEggTime.convertedSeconds
        }
    }
}
