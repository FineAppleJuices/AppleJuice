//
//  AppleJuiceApp.swift
//  AppleJuice
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

@main
struct AppleJuiceApp: App {
    // @UIApplicationDelegateAdaptor를 통해 AppDelegate 생명주기 이용
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        saveLastLoginDate() // 앱 실행 시 호출
        
    }
    
    var body: some Scene {
        WindowGroup {
            GoalHistoryView()
        }
    }
}

// 앱이 시작될 때 마지막 접속 일자를 저장
func saveLastLoginDate() {
    // 현재 날짜 가져오기
    let currentDate = Date()
    
    // 컴포넌트 설정
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
    components.hour = 0
    components.minute = 0
    
    // 새로운 날짜 객체 생성 (시간을 00:00으로 설정)
    let dateToSave = calendar.date(from: components)

    // UserDefaults에 변환한 Date 저장
    UserDefaults.standard.set(dateToSave!, forKey: "lastLoginDate")
}

// 마지막 접속 일자를 가지고 오기
func getLastLoginDate() -> Date? {
    return UserDefaults.standard.object(forKey: "lastLoginDate") as? Date
}
