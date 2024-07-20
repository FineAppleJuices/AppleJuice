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
    var body: some Scene {
        WindowGroup {
            GoalHistoryView()
        }
    }
}
