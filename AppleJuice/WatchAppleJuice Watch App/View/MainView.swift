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
    
    var body: some View {
        
        NavigationStack(path: $path){
            ZStack{
                
                //걸음 수에 따라 배경이미지 변경
                vm.walkingLevel.mileStoneView
                
                VStack(spacing: 20) {
                    Text("\(vm.stepCount)")
                    
                    //걸음 수에 따라 버튼 활성화 조절
                    HStack(spacing: 12){
                        ForEach(InteractionType.allCases){ type in
                            Button(action: {
                                path.append(type)
                            }, label: {
                                Image(systemName: type.iconImage)
                                    .imageScale(.large)
                            })
                            .disabled(!(type.milestone...).contains(vm.stepCount))
                        }
                    }

                }
            }
            .navigationDestination(for: InteractionType.self) { type in
                InteractionView(interactionType: type, path: $path)
            }
            .toolbar{
                // 정해진 mileStone이 있는 경우에만 랜더링
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            //cp.sendMessage(message: [ "key" : true])
                            //버튼 눌러서 날짜(yyyy-mm-dd) 보내기
                            cp.sendMessage(message: [ "date" : Date().toString()])
                            
                            //테스트용
                            vm.stepCount += 1000
                            
                        }, label: {
                            Image(systemName: "carrot.fill")
                        })
                    }
                

            }
        }

        
    }
}

#Preview {
    MainView()
}
