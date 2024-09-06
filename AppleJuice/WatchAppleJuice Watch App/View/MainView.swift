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
                    Text("\(sm.stepCount)")
                        .font(Font.custom("Galmuri7", size: 16))
                }
                //TODO: 테스트 용으로 일단 기준 8000보로 낮춤;
                if sm.stepCount >= 8000 && juiceButtonVisible {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            cp.sendMessage(message: ["date": Date()])
                            
                            //TODO: 버튼 눌렀을 때 축하 애니메이션
                            
                            //TODO: 메인화면 사과 캐릭터에서 주스 캐릭터로 바뀌기
                            
                            //만보 축하 애니메이션 지난 후에는 주스 버튼 사라지게 하기
                            juiceButtonVisible = false
                        }, label: {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        })
                    }
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
                            .disabled(!(type.milestone...).contains(sm.stepCount))
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
