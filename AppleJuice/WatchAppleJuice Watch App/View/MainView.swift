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
    @StateObject private var cp = ConnectivityProvider()
<<<<<<< HEAD
    
    @State private var currentIndex = 0
    @StateObject private var viewModel = AnimationViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    
=======
>>>>>>> main
    
    var body: some View {
        
        NavigationStack(path: $path){
<<<<<<< HEAD
<<<<<<< HEAD
            ZStack {
                Image("watchbackground")
                    .resizable()
                    .frame(width: 162, height: 200)
                    .padding(.bottom, 16)
                
                Image(viewModel.currentFrame)
                    .resizable()
                    .frame(width: 182, height: 182)
                    .animation(.linear(duration: 0.001), value: viewModel.currentFrame)
                    .padding(.bottom,46)
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 10){
=======
=======
>>>>>>> main
            ZStack{
                
                //걸음 수에 따라 배경이미지 변경
                vm.walkingLevel.mileStoneView
                
                VStack(spacing: 20) {
                    Text("\(vm.stepCount)")
                    
                    //걸음 수에 따라 버튼 활성화 조절
                    HStack(spacing: 12){
>>>>>>> main
                        ForEach(InteractionType.allCases){ type in
                            Button(action: {
                                path.append(type)
                            }, label: {
                                Image("\(type.iconImage)")
                                    .resizable()
                                    .frame(width: 40, height: 40)
//                                ZStack {
////                                    Circle()
////                                        .frame(width: 40, height: 40)
////                                        .foregroundColor(Color.black.opacity(0.8))
//                                    Image("\(type.iconImage)")
//                                        .frame(width: 40, height: 40)
////                                        .imageScale(.large)
//                                }
                            })
<<<<<<< HEAD
<<<<<<< HEAD
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                    .padding(.bottom, 30)
=======
                            .disabled(!(type.milestone...).contains(vm.stepCount))
                        }
                    }

>>>>>>> main
=======
                            .disabled(!(type.milestone...).contains(vm.stepCount))
                        }
                    }

>>>>>>> main
                }
            }
            .navigationDestination(for: InteractionType.self) { type in
                InteractionView(interactionType: type, path: $path)
            }
            .toolbar{
                // 정해진 mileStone이 있는 경우에만 랜더링
<<<<<<< HEAD
<<<<<<< HEAD
                if let milestone = vm.dailyStatus.mileStone {
                    //milestone이 .tenThousand이 되면 주스 버튼 활성화
=======
=======
>>>>>>> main
                    
>>>>>>> main
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            //cp.sendMessage(message: [ "key" : true])
                            //버튼 눌러서 날짜(yyyy-mm-dd) 보내기
                            cp.sendMessage(message: [ "date" : Date().toString()])
                            
                            //테스트용
                            vm.stepCount += 1000
                            
                        }, label: {
<<<<<<< HEAD
<<<<<<< HEAD
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.red.opacity(0.8))
                                Image(systemName: vm.dailyStatus.mileStone?.iconName ?? "waterbottle")
                            }
=======
                            Image(systemName: "carrot.fill")
>>>>>>> main
=======
                            Image(systemName: "carrot.fill")
>>>>>>> main
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
<<<<<<< HEAD
<<<<<<< HEAD
                }
=======
=======
>>>>>>> main
                

>>>>>>> main
            }
        }
        
        
    }
}

#Preview {
    MainView()
}
