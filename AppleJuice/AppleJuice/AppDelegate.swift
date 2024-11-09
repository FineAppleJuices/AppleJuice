//
//  AppDelegate.swift
//  AppleJuice
//
//  Created by 이종선 on 7/15/24.
//

import SwiftUI
import WatchConnectivity

class AppDelegate: NSObject, UIApplicationDelegate, WCSessionDelegate {
    
    var session: WCSession {
        WCSession.default
    }
    
    // 앱이 시작될때 호출되는 메서드, WatchConnectivity 세션을 설정하고 활성화
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        saveLastLoginDate() // 앱이 액티브 상태에서 나갈때 마지막 접속 날짜를 저장
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveLastLoginDate() // 앱이 백그라운드모드에 들어갈때 마지막 접속 날짜를 저장
    }

    
    // WCSession이 활성화 될때 호출되는 메서드, 세션 활성화 상태와 오류를 처리
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session activation failed with error: \(error.localizedDescription)")
            return
        }
        print("Session activated with state: \(activationState)")
    }
    
    // WatchOS로부터 메서지를 수신했을 때 호출되는 메서드
    // 앱 활성화 되어 있을때만 동작
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .didReceiveWatchMessage, object: message)
        }
    }
    // 앱이 활성화 되지 않았어도 다음 앱 실행시 수신 보장 
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .didReceiveWatchMessage, object: applicationContext)
        }
    }
    
    // 세션 비활성화 될때 호출되는 메서드
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    // 세션 해제될 때 호출되는 메서드 
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}

extension Notification.Name {
    static let didReceiveWatchMessage = Notification.Name("didReceiveWatchMessage")
}

