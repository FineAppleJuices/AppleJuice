//
//  AnimationViewModel.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/29/24.
//

import SwiftUI
import Combine

class AnimationViewModel: ObservableObject {
    
    @Published var currentFrame: String
    private var timer: AnyCancellable?
    private let frameNames: [String]
    private var currentIndex = 0

    init(frameNames: [String]) {
        self.frameNames = frameNames
        self.currentFrame = frameNames.first ?? ""
        startAnimation()
    }

    private func startAnimation() {
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                /// 프레임 index 결정 방법
                /// 전체 frame개수가 3인 경우, 각 frame index [0, 1, 2]
                ///  1 : (0 + 1) % 3 = 1 (currentIndex)
                ///  2 : (1 + 1) % 3 = 2 (currentIndex)
                ///  3 : (2 + 1) % 3 = 0 (currentIndex)
                ///  4 : (0 + 1) % 3 = 1 (currentIndex)
                self.currentIndex = (self.currentIndex + 1) % self.frameNames.count
                self.currentFrame = self.frameNames[self.currentIndex]
            }
    }
    
    deinit {
        timer?.cancel()
    }
}
