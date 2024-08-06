//
//  WalkingLevel.swift
//  WatchAppleJuice Watch App
//
//  Created by Kyuhee hong on 7/28/24.
//

import Foundation
import SwiftUI

enum WalkingLevel {
    case level0
    case level1000
    case level3000
    case level5000
    case level7000
    case level10000
    
    @ViewBuilder
    var mileStoneView: some View {
        switch self {
        case .level0:
            BackgroundView(mileStoneViewImage: "cat")
        case .level1000:
            BackgroundView(mileStoneViewImage: "1000")
        case .level3000:
            BackgroundView(mileStoneViewImage: "3000")
        case .level5000:
            BackgroundView(mileStoneViewImage: "")
        case .level7000:
            BackgroundView(mileStoneViewImage: "7000")
        case .level10000:
            BackgroundView(mileStoneViewImage: "10000")
        }
    }
}
