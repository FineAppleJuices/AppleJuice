//
//  ContentView.swift
//  AppleJuice
//
//  Created by 이종선 on 6/24/24.

import SwiftUI

struct GoalHistoryView: View {
    
    @StateObject private var vm: GoalHistoryViewModel
    @StateObject private var cp: ConnectivityProvider
    @State private var currentPage = 0
    @State private var showTooltip: Bool = false
    @State private var tooltipSteps: Int = 0
    @State private var tooltipPosition: CGPoint = .zero
    @State private var selectedJuiceIndex: Int? = nil
    
    init(useSampleData: Bool = false) {
        let viewModel = GoalHistoryViewModel(useSampleData: useSampleData)
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
            
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Image("fridge")
                            .resizable()
                            .overlay(
                                GeometryReader { fridgeGeometry in
                                    VStack(spacing: fridgeGeometry.size.height * -0.006) {
                                        Spacer().frame(height: fridgeGeometry.size.height * 0.33)
                                        
                                        ForEach(0..<4, id: \.self) { rowIndex in
                                            HStack(spacing: fridgeGeometry.size.width * 0.02) {
                                                ForEach(0..<5) { columnIndex in
                                                    let index = rowIndex * 5 + columnIndex
                                                    let entries = Array(vm.juiceEntries.sorted(by: { $0.date < $1.date }).dropFirst(currentPage * 20).prefix(20))
                                                    ZStack {
                                                        if index < entries.count {
                                                            let entry = entries[index]
                                                            VStack {
                                                                Image("juice")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: fridgeGeometry.size.width * 0.09)
                                                                    .onTapGesture {
                                                                        tooltipSteps = entry.steps
                                                                        selectedJuiceIndex = index
                                                                        showTooltip.toggle()
                                                                    }
                                                                
                                                                Text(entry.date, format: Date.FormatStyle()
                                                                    .month(.twoDigits)
                                                                    .day(.twoDigits))
                                                                .foregroundColor(.black)
                                                                .font(.caption)
                                                            }
                                                        }
                                                        if showTooltip && selectedJuiceIndex == index {
                                                            Text("\(tooltipSteps) 걸음")
                                                                .font(Font.custom("Galmuri7", size: 10))
                                                                .padding(8)
                                                                .background(Color.black.opacity(0.7))
                                                                .foregroundColor(.white)
                                                                .cornerRadius(8)
                                                                .offset(y: -50) // 주스 위에 툴팁 표시
                                                                .zIndex(1)
                                                        }
                                                    }
                                                    .frame(width: fridgeGeometry.size.width * 0.12, height: fridgeGeometry.size.height * 0.15)
                                                }
                                            }
                                            
                                            Image("bar")
                                                .resizable()
                                                .frame(width: fridgeGeometry.size.width * 0.8, height: fridgeGeometry.size.height * 0.01)
                                        }
                                    }
                                    .padding(EdgeInsets(top: fridgeGeometry.size.height * 0.02, leading: fridgeGeometry.size.width * 0.09, bottom: fridgeGeometry.size.height * 0.05, trailing: fridgeGeometry.size.width * 0.05))
                                }
                            )
                        Spacer()
                    }
                    
                    // 다음 냉장고 및 이전 냉장고 버튼 겹쳐서 표시
                    VStack {
                        HStack {
                            if currentPage > 0 {
                                Button(action: {
                                    currentPage -= 1
                                    showTooltip = false
                                }) {
                                    Text("이전 냉장고")
                                        .font(Font.custom("Galmuri7", size: 16))
                                        .padding(7)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            
                            Spacer()
                            
                            if (currentPage + 1) * 20 < vm.juiceEntries.count {
                                Button(action: {
                                    currentPage += 1
                                    showTooltip = false
                                }) {
                                    Text("다음 냉장고")
                                        .font(Font.custom("Galmuri7", size: 16))
                                        .padding(7)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .zIndex(2) // 버튼을 가장 앞에 표시
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom) // 버튼을 하단에 고정
                }
            }
        }
        .onTapGesture {
            if showTooltip {
                showTooltip = false
            }
        }
        .onChange(of: vm.juiceEntries) { oldValue, newValue in
            print("Juice entries updated: \(newValue.count)")
        }
    }
}

#Preview {
    GoalHistoryView(useSampleData: true)
}

