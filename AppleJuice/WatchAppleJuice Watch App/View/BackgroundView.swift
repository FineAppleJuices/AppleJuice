//
//  BackgroundView.swift
//  WatchAppleJuice Watch App
//
//  Created by Kyuhee hong on 7/28/24.
//

import SwiftUI

struct BackgroundView: View {
    var mileStoneViewImage = ""
    
    var body: some View {
        Image(mileStoneViewImage)
            .resizable()
            .scaledToFit()
            .opacity(0.2)
    }
}

#Preview {
    BackgroundView()
}
