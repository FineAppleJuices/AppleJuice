//
//  ContentView.swift
//  AppleJuice
//
//  Created by 이종선 on 6/24/24.
//

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
        let viewModel = GoalHistoryViewModel()
        _vm = StateObject(wrappedValue: viewModel)
        _cp = StateObject(wrappedValue: ConnectivityProvider(viewModel: viewModel))
    }
    
    var body: some View {
        ZStack {
            Image("main")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                headerView
                Spacer()
            }
            
            GeometryReader { geometry in
                ZStack {
                    juiceFridgeView(geometry: geometry)
                    
                    if showTooltip {
                        tooltipView
                    }
                    
                    navigationButtons(geometry: geometry)
                }
            }
        }
        .onTapGesture {
            if showTooltip {
                showTooltip = false
            }
        }
        .onChange(of: vm.statusList) { oldValue, newValue in
            print("Juice entries updated: \(newValue.count)")
        }
    }
    
    private var headerView: some View {
        Text("주스 냉장고")
            .foregroundColor(.white)
            .padding(50)
            .font(Font.custom("Galmuri7", size: 48))
    }
    
    private func juiceFridgeView(geometry: GeometryProxy) -> some View {
        VStack {
            Image("fridge")
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.height * 1.08)
                .offset(y: -geometry.size.height * 0.09)
                .overlay(
                    JuiceGridView(
                        geometry: geometry,
                        entries: Array(vm.statusList.sorted(by: { $0.date < $1.date }).dropFirst(currentPage * 20).prefix(20)),
                        currentPage: currentPage,
                        tooltipSteps: $tooltipSteps,
                        selectedJuiceIndex: $selectedJuiceIndex,
                        tooltipPosition: $tooltipPosition,
                        showTooltip: $showTooltip
                    )
                )
            Spacer()
        }
    }
    
    private var tooltipView: some View {
        VStack {
            Spacer()
            Text("\(tooltipSteps) 걸음")
                .font(Font.custom("Galmuri7", size: 16))
                .padding(8)
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
                .position(x: tooltipPosition.x, y: tooltipPosition.y - 30)
        }
        .zIndex(2)
    }
    
    private func navigationButtons(geometry: GeometryProxy) -> some View {
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
                
                if (currentPage + 1) * 20 < vm.statusList.count {
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
            .padding(50)
            .zIndex(2)
        }
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
    }
}

struct JuiceGridView: View {
    let geometry: GeometryProxy
    let entries: [DailyStatus]
    let currentPage: Int
    @Binding var tooltipSteps: Int
    @Binding var selectedJuiceIndex: Int?
    @Binding var tooltipPosition: CGPoint
    @Binding var showTooltip: Bool
    
    var body: some View {
        VStack(spacing: geometry.size.height * -0.01) {
            Spacer().frame(height: geometry.size.height * 0.07)
            ForEach(0..<4, id: \.self) { rowIndex in
                HStack(spacing: geometry.size.width * 0.02) {
                    ForEach(0..<5) { columnIndex in
                        let index = rowIndex * 5 + columnIndex
                        let entry = entries[safe: index]
                        ZStack {
                            if let entry = entry {
                                GeometryReader { juiceGeometry in
                                    VStack {
                                        Spacer()
                                        Image("juice")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.1)
                                            .onTapGesture {
                                                tooltipSteps = entry.steps
                                                selectedJuiceIndex = index
                                                tooltipPosition = CGPoint(
                                                    x: juiceGeometry.frame(in: .global).midX,
                                                    y: juiceGeometry.frame(in: .global).minY
                                                )
                                                showTooltip.toggle()
                                            }
                                        Text(entry.date, format: Date.FormatStyle()
                                            .month(.twoDigits)
                                            .day(.twoDigits))
                                        .foregroundColor(.black)
                                        .font(Font.custom("Galmuri7", size: 16))
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width * 0.13, height: geometry.size.height * 0.15)
                    }
                }
                Image("bar")
                    .resizable()
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.01)
            }
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    GoalHistoryView()
}
