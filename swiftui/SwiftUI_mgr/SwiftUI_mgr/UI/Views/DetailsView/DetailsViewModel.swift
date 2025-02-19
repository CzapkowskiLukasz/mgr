//
//  DetailsViewModel.swift
//  SwiftUI_mgr
//
//  Created by Łukasz Czapkowski on 02/02/2025.
//

import Foundation

class DetailsViewModel: ObservableObject {
    @Published var game: Game
    
    init(game: Game) {
        self.game = game
    }
}
