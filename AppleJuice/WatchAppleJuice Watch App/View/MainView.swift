//
//  ContentView.swift
//  WatchAppleJuice Watch App
//
//  Created by 이종선 on 6/24/24.
//

import SwiftUI

// Apple Watch Main View

struct MainView: View {
    
    @State private var path = NavigationPath()
    @StateObject private var vm = MainViewModel()
    @StateObject private var cp = ConnectivityProvider()
    
    var body: some View {
        
        NavigationStack(path: $path){
            ZStack{
                VStack(spacing: 20) {
                    Image(systemName: "cat.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    Spacer()
                    
                    
                    HStack(spacing: 12){
                        ForEach(InteractionType.allCases){ type in
                            Button(action: {
                                path.append(type)
                            }, label: {
                                Image(systemName: type.iconImage)
                                    .imageScale(.large)
                            })
                            
                        }
                    }
                    
                }
            }
            .navigationDestination(for: InteractionType.self) { type in
                AnimationView(interactionType: type, path: $path)
            }
            .toolbar{
                // 정해진 mileStone이 있는 경우에만 랜더링
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            //cp.sendMessage(message: [ "key" : true])
                            
                            //날짜 설정
                            let currentDate = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let formattedDate = dateFormatter.string(from: currentDate)

                            print(formattedDate)
                            cp.sendMessage(message: [ "date" : formattedDate])
                            
                        }, label: {
                            Image(systemName: "carrot.fill")
                        })
                    }
                

            }
        }

        
    }
}

#Preview {
    MainView()
}
