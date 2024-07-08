//
//  ContentView.swift
//  AppleJuice
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

struct GoalHistoryView: View {
    
    @StateObject private var vm = GoalHistoryViewModel()
    
    var body: some View {
        ZStack {
            Image("mainSky")
                .resizable()
                .ignoresSafeArea()
            Text("Hello, world!")
        }
    }
}

#Preview {
    GoalHistoryView()
}
