//
//  ListCellViewModel.swift
//  SwiftUI_mgr
//
//  Created by Łukasz Czapkowski on 02/01/2025.
//

import Foundation

class ListCellViewModel: ObservableObject {
    let game: Game
    
    init(game: Game) {
        self.game = game
    }
}
