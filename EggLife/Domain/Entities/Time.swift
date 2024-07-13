//
//  Time.swift
//  EggLife
//
//  Created by 곽서방 on 7/8/24.
//

import Foundation

struct Time {
    //시, 분, 초, 변환된ㄷ 시간
    var minutes: Int
    var seconds: Int
    
    var convertedSeconds: Int {
        return (minutes * 60) + seconds
        
    }
    static func fromSeconds(_ seconds: Int) -> Time {
        let m = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return Time(minutes: m, seconds: remainingSeconds)
    }
}
