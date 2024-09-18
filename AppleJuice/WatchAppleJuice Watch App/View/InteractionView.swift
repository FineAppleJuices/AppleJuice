//
//  InteractionView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/28/24.
//

import SwiftUI

struct InteractionView: View {
    @StateObject var vm: InteractionViewModel
    @Binding var path: NavigationPath
    
    init(interactionType: InteractionType, path: Binding<NavigationPath>) {
        _vm = StateObject(wrappedValue: InteractionViewModel(frameNames: interactionType.frameNames))
        _path = path
    }
    
    var body : some View {
        VStack {
            Image(vm.currentFrame)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .animation(.linear(duration: 0.001), value: vm.currentFrame)
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Rectangle()
                    .opacity(0)
            }
        }
        .onChange(of: vm.shouldNavigateBack) { oldValue, newValue in
            if newValue {
                path.removeLast()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

