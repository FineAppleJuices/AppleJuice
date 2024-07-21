//
//  ContentView.swift
//  AppleJuice
//
//  Created by 이종선 on 6/24/24.

import SwiftUI

struct GoalHistoryView: View {
    
    @StateObject private var vm = GoalHistoryViewModel()
    @StateObject private var cp: ConnectivityProvider
    @State private var currentPage = 0

    init() {
        let viewModel = GoalHistoryViewModel()
        _vm = StateObject(wrappedValue: viewModel)
        _cp = StateObject(wrappedValue: ConnectivityProvider(viewModel: viewModel))
    }

    var body: some View {
        ZStack {
            Image("mainSky")
                .resizable()
                .ignoresSafeArea()

            VStack {
                Text("주스 냉장고")
                    .foregroundColor(.white)
                    .padding(30)
                    .font(Font.custom("Galmuri7", size: 48))
                Spacer()
            }
            Image("fridge")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    let entries = Array(vm.juiceEntries.dropFirst(currentPage * 25).prefix(25))
                    ForEach(0..<entries.count, id: \.self) { index in
                        if index % 5 == 0 && index != 0 {
                            Image("bar")
                                .resizable()
                                .frame(width: 300, height: 10)
                                .padding(40)
                        }
                        let entry = entries[index]
                        VStack {
                            Image("juice")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .onTapGesture {
                                    showStepsTooltip(entry.steps)
                                }
                                .overlay(
                                    Text(entry.date, style: .date)
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .padding(.top, 35)
                                )
                        }
                    }
                }

                if vm.juiceEntries.count > 25 {
                    HStack {
                        if currentPage > 0 {
                            Button(action: previousPage) {
                                Text("이전 냉장고")
                                    .font(Font.custom("Galmuri7", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        
                        Spacer()
                        
                        if vm.juiceEntries.count > (currentPage + 1) * 25 {
                            Button(action: nextPage) {
                                Text("다음 냉장고")
                                    .font(Font.custom("Galmuri7", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            print("GoalHistoryView appeared")
        }
        .onChange(of: vm.juiceEntries) { oldValue, newValue in
            print("Juice entries updated: \(newValue.count)")
        }
    }

    private func showStepsTooltip(_ steps: Int) {
        // 걸음 수 툴팁 표시 로직 추가
        print("걸음 수: \(steps)")
    }

    private func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }

    private func nextPage() {
        if (currentPage + 1) * 25 < vm.juiceEntries.count {
            currentPage += 1
        }
    }
}

#Preview {
    GoalHistoryView()
}

