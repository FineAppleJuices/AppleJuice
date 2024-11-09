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
    @State private var showCelebrationView = false
    
    @StateObject private var viewModel = InteractionViewModel(frameNames: ["green1", "green2", "green3"], infinite: true)
    @StateObject private var seventhousandviewModel = InteractionViewModel(frameNames: ["red1", "red2", "red3"], infinite: true)
    @StateObject private var clearModel = InteractionViewModel(frameNames: ["juice1", "juice2", "juice3"], infinite: true)
    
    var statusOfToday: Bool {
        UserDefaults.standard.object(forKey: Date().toString()) != nil
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                backgroundImage
                
                if isJuiceButtonPushed {
                    if showCelebrationView {
                        celebrationView
                    }
                    animatedClearView
                } else if sm.stepCount >= 7000 && isAppleRed {
                    animatedRedView
                } else {
                    animatedGreenView
                }
            }
            .onChange(of: sm.stepCount) { newValue, oldValue in
                if newValue >= 10000 && !isJuiceButtonPushed && !statusOfToday {
                    juiceButtonVisible = true
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
                stepCountToolbar
                juiceButtonToolbar
                interactionButtonsToolbar
            }
        }
    }
    
    private var backgroundImage: some View {
        Image(isJuiceButtonPushed ? "watchbackground2" : "watchbackground")
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .scaledToFill()
    }
    
    private var animatedClearView: some View {
        Image(clearModel.currentFrame)
            .resizable()
            .animation(.linear(duration: 0.001), value: clearModel.currentFrame)
            .padding(.bottom, 8)
    }
    
    private var celebrationView: some View {
        VStack {
            Image("juiceclear")
                .resizable()
                .padding(.bottom, 8)
            HStack {
                Text("You made Apple Juice !")
                    .font(Font.custom("Galmuri7", size: 11))
                    .foregroundColor(.black)
                    .padding(.top, 12)
                    .padding(.leading, 8)
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showCelebrationView = false // 3초 후에 다시 안보이게 하기
            }
        }
    }
    
    private var animatedRedView: some View {
        Image(seventhousandviewModel.currentFrame)
            .resizable()
            .animation(.linear(duration: 0.001), value: seventhousandviewModel.currentFrame)
            .padding(.bottom, 8)
    }
    
    private var animatedGreenView: some View {
        Image(viewModel.currentFrame)
            .resizable()
            .animation(.linear(duration: 0.001), value: viewModel.currentFrame)
            .padding(.bottom, 8)
    }
    
    private var stepCountToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text("\(sm.stepCount)")
                .frame(width: 100, alignment: .leading)
                .font(Font.custom("Galmuri7", size: 16))
                .foregroundColor(sm.stepCount >= 10000 ? .black : .white)
        }
    }
    
    private var juiceButtonToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if juiceButtonVisible {
                Button(action: juiceButtonAction, label: {
                    Image("clearbutton")
                })
            }
        }
    }
    
    // 만보 달성 주스 버튼이 눌렸을 때의 액션들 모음
    private func juiceButtonAction() {
        cp.sendMessage(message: ["date": Date()]) // Watch 에 오늘 날짜 보냄
        isStepCountsOver10000 = true // 10000보 달성 플래그
        juiceButtonVisible = false // 버튼 눌렀으니까 다시 안보이도록 변경
        showCelebrationView = true // 축하 애니메이션 보이게 하기
        saveHistory() // UserDefaults 에 오늘 날짜 성공 이력 저장
    }
    
    private var interactionButtonsToolbar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack(spacing: 14) {
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

#Preview {
    MainView()
}
