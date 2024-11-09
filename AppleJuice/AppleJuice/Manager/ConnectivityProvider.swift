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
    
    // WatchOS로부터 메시지 수신시 해당 message 처리
    @objc private func handleMessage(notification: Notification) {
        if let message = notification.object as? [String: Any], let date = message["date"] as? Date {
            DispatchQueue.main.async {
                // WatchOS 에서 날짜 정보를 받으면 해당 날짜의 걸음 수를 받아와서 코어데이터로 저장하기
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
