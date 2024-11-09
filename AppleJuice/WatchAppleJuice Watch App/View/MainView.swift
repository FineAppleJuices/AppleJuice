//
//  ContentView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//
import SwiftUI

struct MainView: View {
    @StateObject private var sm = StepsManager()
    @StateObject private var cp = ConnectivityProvider()
    @State private var path = NavigationPath()
    @State private var currentIndex = 0
    @State private var juiceButtonVisible = false
    @State private var isAppleRed = false
    @State private var isStepCountsOver10000 = false
    @State private var isJuiceButtonPushed = false
    
    var statusOfToday: Bool {
        UserDefaults.standard.object(forKey: Date().toString()) != nil
    }
    
    @StateObject private var viewModel = InteractionViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    @StateObject private var seventhousandviewModel = InteractionViewModel(frameNames: ["red1", "red2", "red3"], infinite: true)
    @StateObject private var clearModel = InteractionViewModel(frameNames: ["juice1", "juice2", "juice3"], infinite: true)
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                //걸음 수가 만보 이상일 때와 만보 이하일 때 배경화면이 바뀜
                if isStepCountsOver10000 {
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
                if isJuiceButtonPushed { // 만보 달성 버튼이 눌렸을때 배경화면이 바뀜
                    Image(clearModel.currentFrame)
                        .resizable()
                        .animation(.linear(duration: 0.001), value: clearModel.currentFrame)
                        .padding(.bottom, 8)
                } else if isStepCountsOver10000 { // 만보 달성 했을때 축하 애니메이션이 나옴
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
                } else if sm.stepCount >= 7000 && isAppleRed == true {
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
            .onChange(of: sm.stepCount) { newValue, oldValue in
                // 걸음 수가 만보에 도달했을 때 juiceButtonVisible을 true로 설정
                if newValue >= 10000 && oldValue < 10000 {
                    // 오늘 날짜 만보 달성 여부 확인 후 버튼을 띄워줍니다.
                    if statusOfToday == false {
                        juiceButtonVisible = true
                    }
                }
            }
            .navigationDestination(for: InteractionType.self) { type in
                InteractionView(interactionType: type, path: $path)
                    .onDisappear {
                        if type == InteractionType.allCases.last && sm.stepCount >= 7000 {
                            isAppleRed = true
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
                
                if juiceButtonVisible { // 주스버튼 보인다!
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            cp.sendMessage(message: ["date": Date()]) // Watch 에 만보 달성한 날짜(오늘) 보내기
                            isStepCountsOver10000 = true // 10000보 달성 스위치
                            juiceButtonVisible = false // 주스버튼 다시 안보이게 하기
                            saveHistory() // 버튼 누르면 오늘 날짜 달성여부 체크해두기
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
    MainView()
}
