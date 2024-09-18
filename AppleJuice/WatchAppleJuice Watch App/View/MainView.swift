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
    @State var ispushed = false
    
    @StateObject private var viewModel = InteractionViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    @StateObject private var seventhousandviewModel = InteractionViewModel(frameNames: ["red1", "red2", "red3"], infinite: true)
    @StateObject private var clearModel = InteractionViewModel(frameNames: ["juice1", "juice2", "juice3"], infinite: true)
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if vm.stepCount >= 10000 {
                    Image("watchbackground2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                } else {
                    Image("watchbackground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
                
                if vm.stepCount > 10000 {
                    Image(clearModel.currentFrame)
                        .resizable()
                        .animation(.linear(duration: 0.001), value: clearModel.currentFrame)
                        .padding(.bottom, 8)
                } else if vm.stepCount == 10000{
                    Image("juiceclear")
                        .resizable()
                        .padding(.bottom, 8)
                    VStack {
                        Text("주스가 된 사과")
                            .font(Font.custom("Galmuri7", size: 20))
                            .foregroundColor(.black)
                            .padding(.top, 15)
                        Spacer()
                    }
                } else if vm.stepCount >= 7000 && ispushed == true {
                    Image(seventhousandviewModel.currentFrame)
                        .resizable()
                        .animation(.linear(duration: 0.001), value: seventhousandviewModel.currentFrame)
                        .padding(.bottom, 8)
                } else {
                    Image(viewModel.currentFrame)
                        .resizable()
                        .animation(.linear(duration: 0.001), value: viewModel.currentFrame)
                        .padding(.bottom, 8)
                }
            }
            .navigationDestination(for: InteractionType.self) { type in
                InteractionView(interactionType: type, path: $path)
                    .onDisappear {
                        if type == InteractionType.allCases.last && vm.stepCount >= 7000 {
                            ispushed = true
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("\(vm.stepCount)")
                        .font(Font.custom("Galmuri7", size: 16))
                        .foregroundColor(vm.stepCount >= 10000 ? .black : .white)
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
    MainView(ispushed: false)
}
