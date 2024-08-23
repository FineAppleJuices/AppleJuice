//
//  WatchConnector.swift
//  AppleJuice
//
//  Created by 이종선 on 7/15/24.
//


import Foundation
import WatchConnectivity
import SwiftUI

class ConnectivityProvider: NSObject, ObservableObject {
    
    @Published var receivedMessage: [String: Any] = [:]
    private var viewModel: GoalHistoryViewModel

    
    // NotificationCenter에 Observer 등록
    init(viewModel: GoalHistoryViewModel) {
        self.viewModel = viewModel
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMessage(notification:)), name: .didReceiveWatchMessage, object: nil)
    }
    
    //     WatchOS로부터 메시지 수신시 해당 message 처리
    @objc private func handleMessage(notification: Notification) {
        if let message = notification.object as? [String: Any], let date = message["date"] as? Date {
            DispatchQueue.main.async {
                self.viewModel.fetchSteps(for: date) { steps in
                    self.viewModel.addJuiceEntry(date: date, steps: steps)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//
//
//
//import Foundation
//import WatchConnectivity
//
//class ConnectivityProvider: NSObject, ObservableObject {
//    
//    @Published var receivedMessage: [String: Any] = [:]
//    
//    // NotificationCenter에 Observer 등록
//    override init() {
//        super.init()
//        NotificationCenter.default.addObserver(self, selector: #selector(handleMessage(notification:)), name: .didReceiveWatchMessage, object: nil)
//    }
//    
//    // WatchOS로부터 메시지 수신시 해당 message 처리
//    @objc private func handleMessage(notification: Notification) {
//        if let message = notification.object as? [String: Any] {
//            DispatchQueue.main.async {
//                self.receivedMessage = message
//            }
//        }
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//}
