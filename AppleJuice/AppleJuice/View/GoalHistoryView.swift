//
//  ContentView.swift
//  AppleJuice
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

struct GoalHistoryView: View {
    
    @StateObject private var vm = GoalHistoryViewModel()
    @StateObject private var cp = ConnectivityProvider()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(cp.receivedMessage.description)")
        }
        .padding()
    }
}

#Preview {
    GoalHistoryView()
}
