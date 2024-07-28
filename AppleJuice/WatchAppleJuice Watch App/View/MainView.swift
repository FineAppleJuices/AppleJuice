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
                VStack(spacing: 20) {
//                    Image(systemName: "cat.fill")
//                        .imageScale(.large)
//                        .foregroundStyle(.tint)
//                    Spacer()
                    
                    //걸음 수에 따라 다른 화면 가지고 오기 (일단 이미지뷰로 박아둠)
                    switch vm.stepCount {
                    case ...999:
                        Image(systemName: "cat.fill")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    case 1000...2999:
                        Image("1000")
                            .resizable()
                            .scaledToFit()
                    case 3000...6999:
                        Image("3000")
                            .resizable()
                            .scaledToFit()
                    case 7000...9999:
                        Image("7000")
                            .resizable()
                            .scaledToFit()
                    case 10000...:
                        Image("10000")
                            .resizable()
                            .scaledToFit()
                    default:
                        Image(systemName: "cat")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    }

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
                AnimationView(interactionType: type, path: $path)
            }
            .toolbar{
                // 정해진 mileStone이 있는 경우에만 랜더링
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            //cp.sendMessage(message: [ "key" : true])
                            
                            //날짜 설정
                            let currentDate = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let formattedDate = dateFormatter.string(from: currentDate)

                            print(formattedDate)
                            cp.sendMessage(message: [ "date" : formattedDate])
                            
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
