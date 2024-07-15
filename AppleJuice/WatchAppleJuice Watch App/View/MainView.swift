//
//  ContentView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

// Apple Watch Main View

struct MainView: View {
    
    @State private var path = NavigationPath()
    @StateObject private var vm = MainViewModel()
    
    @State private var currentIndex = 0
    @StateObject private var viewModel = AnimationViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    
    var body: some View {
        
        NavigationStack(path: $path){
            ZStack {
                Image("watchbackground")
                    .resizable()
                    .frame(width: 162, height: 200)
                    .padding(.bottom, 16)
                
                Image(viewModel.currentFrame)
                    .resizable()
                    .frame(width: 182, height: 182)
                    .animation(.easeInOut(duration: 0.5), value: viewModel.currentFrame)                    .padding(.bottom,46)
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 10){
                        ForEach(InteractionType.allCases){ type in
                            Button(action: {
                                path.append(type)
                            }, label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color.black.opacity(0.8))
                                    Image(systemName: type.iconImage)
                                        .imageScale(.large)
                                }
                            })
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationDestination(for: InteractionType.self) { type in
                AnimationView(interactionType: type, path: $path)
            }
            .toolbar{
                // 정해진 mileStone이 있는 경우에만 랜더링
                if let milestone = vm.dailyStatus.mileStone {
                    //milestone이 .tenThousand이 되면 주스 버튼 활성화
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.red.opacity(0.8))
                                Image(systemName: vm.dailyStatus.mileStone?.iconName ?? "waterbottle")
                            }
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    MainView()
}
