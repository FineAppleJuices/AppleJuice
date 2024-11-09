//
//  WatchAppleJuiceApp.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

@main
struct WatchAppleJuice_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    init() {
        initHistory()
    }
}

// 앱이 최초에 시작될 때 오늘의 날짜와 만보 달성 여부를 저장 (key: 날짜, value: 달성여부)
// UserDefaults에 해당 날짜의 value 가 없으면 false로 저장
func initHistory() {
    if UserDefaults.standard.object(forKey: Date().toString()) == nil {
        UserDefaults.standard.set(false, forKey: Date().toString())
    }
}

func saveHistory() {
    UserDefaults.standard.set(true, forKey: Date().toString())
}
