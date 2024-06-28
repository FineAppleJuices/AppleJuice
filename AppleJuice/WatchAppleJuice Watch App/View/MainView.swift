//
//  ContentView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

// Apple Watch Main View

struct MainView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cat.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Spacer()
            
            // 상호작용 버튼
            HStack(spacing:12){
                Button(action: {}, label: {
                    Image(systemName: "shower.fill")
                        .imageScale(.large)
                })
                Button(action: {}, label: {
                    Image(systemName: "sun.max.fill")
                        .imageScale(.large)
                })
                Button(action: {}, label: {
                    Image(systemName: "wand.and.stars")
                        .imageScale(.large)
                })
            }
        }
        .padding()
    }
}

#Preview {
    MainView()
}
