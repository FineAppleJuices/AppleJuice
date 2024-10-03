//
//  ContentView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//
import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    @StateObject private var sm = StepsManager()
    @StateObject private var cp = ConnectivityProvider()
    @State private var currentIndex = 0
    @State private var juiceButtonVisible = true
    @State var ispushed = false
    
    @StateObject private var viewModel = InteractionViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    @StateObject private var seventhousandviewModel = InteractionViewModel(frameNames: ["red1", "red2", "red3"], infinite: true)
    @StateObject private var clearModel = InteractionViewModel(frameNames: ["juice1", "juice2", "juice3"], infinite: true)
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                //걸음 수가 만보 이상일 때와 만보 이하일 때 배경화면이 바뀜
                if sm.stepCount >= 10000 {
                    Image("watchbackground2")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                } else {
                    Image("watchbackground")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
                
                //걸음 수 만보 이상일때 캐릭터 움직임 애니메이션
                if sm.stepCount > 10000 {
                    Image(clearModel.currentFrame)
                        .resizable()
                        .animation(.linear(duration: 0.001), value: clearModel.currentFrame)
                        .padding(.bottom, 8)
                } else if sm.stepCount == 10000 {
                    Image("juiceclear")
                        .resizable()
                        .padding(.bottom, 8)
                    VStack {
                        HStack {
                            Text("You made Apple Juice !")
                                .font(Font.custom("Galmuri7", size: 11))
                                .foregroundColor(.black)
                                .padding(.top, 12)
                                .padding(.leading, 8)
                            Spacer()
                        }
                        Spacer()
                    }
                } else if sm.stepCount >= 7000 && ispushed == true {
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
                
//                // 시범용 버튼
//                Button(action: {
//                    sm.stepCount += 2000
//                }, label: {
//                    Text("push")
//                })
//                .frame(width: 80)
            }
            .navigationDestination(for: InteractionType.self) { type in
                InteractionView(interactionType: type, path: $path)
                    .onDisappear {
                        if type == InteractionType.allCases.last && sm.stepCount >= 7000 {
                            ispushed = true
                        }
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("\(sm.stepCount)")
                        .frame(width: 100, alignment: .leading)
                        .font(Font.custom("Galmuri7", size: 16))
                        .foregroundColor(sm.stepCount >= 10000 ? .black : .white)
                }
                
                if sm.stepCount >= 10000 && juiceButtonVisible {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            cp.sendMessage(message: ["date": Date()])
                            
                            //TODO: 버튼 눌렀을 때 축하 애니메이션
                                                        
                            //만보 축하 애니메이션 지난 후에는 주스 버튼 사라지게 하기
                            juiceButtonVisible = false
                        }, label: {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        })
                    }
                    
                }
                
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 14){
                        ForEach(InteractionType.allCases) { type in
                            Button(action: {
                                path.append(type)
                            }, label: {
                                Image("\(type.iconImage)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 34)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .disabled(!(type.milestone...).contains(sm.stepCount))
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
