//
//  WatchConnector.swift
//  AppleJuice
//
//  Created by 이종선 on 7/15/24.
//

import Foundation
import WatchConnectivity

class ConnectivityProvider: NSObject, ObservableObject {
    
    @Published var receivedMessage: [String: Any] = [:]
    
    // NotificationCenter에 Observer 등록
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMessage(notification:)), name: .didReceiveWatchMessage, object: nil)
    }
    
    // WatchOS로부터 메시지 수신시 해당 message 처리
    @objc private func handleMessage(notification: Notification) {
        if let message = notification.object as? [String: Any] {
            DispatchQueue.main.async {
                self.receivedMessage = message
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
