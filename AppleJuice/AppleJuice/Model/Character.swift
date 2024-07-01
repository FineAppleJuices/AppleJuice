//
//  Character.swift
//  AppleJuice
//
//  Created by 이종선 on 6/28/24.
//

import Foundation

struct Character : Identifiable {
    let id: String = UUID().uuidString
    var type: CharacterType
    var name: String
    
    // MARK: 일단 각 Character의 이름은 type의 이름과 같게 하되 향후 사용자에게 이름을 입력받아 설정할 수 있게 열어둠 
    init(type: CharacterType) {
        self.type = type
        self.name = type.rawValue
    }
}
