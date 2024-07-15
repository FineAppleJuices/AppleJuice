//
//  ConnectivityProvider.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 7/15/24.
//

import WatchConnectivity
import SwiftUI

class ConnectivityProvider: NSObject, ObservableObject, WCSessionDelegate {
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    // 세션 활성화시 호출
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session activation failed with error: \(error.localizedDescription)")
            return
        }
        print("Session activated with state: \(activationState)")
    }
    
    // message 전달
    func sendMessage(message: [String: Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
        } else {
            do {
                try WCSession.default.updateApplicationContext(message)
            } catch {
                print("Error updating application context: \(error.localizedDescription)")
            }
        }
    }
}

