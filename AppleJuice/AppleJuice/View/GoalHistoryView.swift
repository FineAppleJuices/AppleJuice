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
            Image("fridge")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("주스 냉장고")
                    .foregroundColor(.white)
                    .padding(30)
                    .font(Font.custom("Galmuri7", size: 48))
                Spacer()
            }
            VStack{
                Spacer()
                Image("bar")
                    .resizable()
                    .frame(width: 300, height: 10)
                    .padding(40)
                Image("bar")
                    .resizable()
                    .frame(width: 300, height: 10)
                    .padding(40)
                Image("bar")
                    .resizable()
                    .frame(width: 300, height: 10)
                    .padding(40)
                Image("bar")
                    .resizable()
                    .frame(width: 300, height: 10)
                    .padding(40)
                Image("bar")
                    .resizable()
                    .frame(width: 300, height: 10)
                    .padding(40)
            }
        }
    }
}

#Preview {
    GoalHistoryView()
}
