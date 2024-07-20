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
<<<<<<< HEAD
        ZStack {
            Image("mainSky")
                .resizable()
                .ignoresSafeArea()

            VStack{
                Text("주스 냉장고")
                    .foregroundColor(.white)
                    .padding(30)
                    .font(Font.custom("Galmuri7", size: 48))
                Spacer()
            }
            Image("fridge")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack{
                    HStack{
                        Image("juice")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                        Image("bar")
                            .resizable()
                            .frame(width: 300, height: 10)
                            .padding(40)
                    
                }
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
=======
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(cp.receivedMessage.description)")
>>>>>>> feat/#13-connect-watch
        }
    }
}

#Preview {
    GoalHistoryView()
}
