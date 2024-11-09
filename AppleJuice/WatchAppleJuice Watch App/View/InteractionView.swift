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
        Image(vm.currentFrame)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .animation(.linear(duration: 0.001), value: vm.currentFrame)
            .onChange(of: vm.shouldNavigateBack) { oldValue, newValue in
                if newValue {
                    path.removeLast()
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

