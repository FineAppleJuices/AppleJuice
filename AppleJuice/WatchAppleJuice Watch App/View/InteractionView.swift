//
//  InteractionView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/28/24.
//

import SwiftUI

struct AnimationView : View {
    
    @StateObject var vm: AnimationViewModel
    @Binding var path: NavigationPath
    
    init(interactionType: InteractionType, path: Binding<NavigationPath>) {
        _vm = StateObject(wrappedValue: AnimationViewModel(frameNames: interactionType.frameNames))
        _path = path
    }
    
    var body : some View {
        
        VStack {
            Image(vm.currentFrame)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .animation(.easeInOut(duration: 0.1), value: vm.currentFrame)
        }
        .onChange(of: vm.shouldNavigateBack) { oldValue, newValue in
            if newValue {
                path.removeLast()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

