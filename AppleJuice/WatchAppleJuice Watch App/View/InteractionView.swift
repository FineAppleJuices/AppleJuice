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
<<<<<<< HEAD
        
        VStack(spacing: 0) {
=======
        VStack {
>>>>>>> main
            Image(vm.currentFrame)
                .resizable()
                .frame(width: 162, height: 204)
                .padding(.bottom, 10)
                .animation(.linear(duration: 0.001), value: vm.currentFrame)
        }
        .onChange(of: vm.shouldNavigateBack) { oldValue, newValue in
            if newValue {
                path.removeLast()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

