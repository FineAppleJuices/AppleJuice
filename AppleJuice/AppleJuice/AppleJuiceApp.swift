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
    let currentDate = Date() // 현재 날짜 가져오기
    UserDefaults.standard.set(currentDate, forKey: "lastLoginDate") // UserDefaults에 저장
}

// 마지막 접속 일자를 가지고 오기
func getLastLoginDate() -> Date? {
    return UserDefaults.standard.object(forKey: "lastLoginDate") as? Date
}
