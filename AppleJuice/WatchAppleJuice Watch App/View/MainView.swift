//
//  ContentView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//
import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    @StateObject private var vm = MainViewModel()
    @StateObject private var cp = ConnectivityProvider()
    @State private var currentIndex = 0
    @StateObject private var viewModel = InteractionViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Image("watchbackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                
                Image(viewModel.currentFrame)
                    .resizable()
                    .scaledToFill()
                    .animation(.linear(duration: 0.001), value: viewModel.currentFrame)
                    .padding(.bottom, 12)
                
            }
            .navigationDestination(for: InteractionType.self) { type in
                InteractionView(interactionType: type, path: $path)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("\(vm.stepCount)")
                        .font(Font.custom("Galmuri7", size: 16))
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        cp.sendMessage(message: ["date": Date().toString()])
                        vm.stepCount += 1000
                    }, label: {
                        Image(systemName: "carrot.fill")
                    })
                }
                
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 20){
                        ForEach(InteractionType.allCases) { type in
                            Button(action: {
                                path.append(type)
                            }, label: {
                                Image("\(type.iconImage)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .disabled(!(type.milestone...).contains(vm.stepCount))
                        }
                    }
                }
            }
            

        }
    }
}

#Preview {
    MainView()
}
