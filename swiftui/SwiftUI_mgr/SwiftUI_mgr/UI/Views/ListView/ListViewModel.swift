//
//  ListViewModel.swift
//  SwiftUI_mgr
//
//  Created by Łukasz Czapkowski on 19/01/2025.
//

import Foundation
import Combine
import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var games: [Game] = []
    @Published var search: String = ""
    @Published var isLoading: Bool = true
    
    private var pagination: Pagination = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        fetchGames()
        
        setupBindings()
    }
    
    private func setupBindings() {
        $search
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink{ [weak self] newValue in
                guard let self = self else { return }
                
                games = []
                pagination = .init()
                fetchGames(search: newValue)
                
            }.store(in: &cancellables)
    }
    
    func fetchGames(search: String? = nil) {
        Task {
            do {
                isLoading = true
                
                let games = try await download(search: search)
                
                DispatchQueue.main.async {
                    self.games.append(contentsOf: games)
                }
                
                isLoading = false
                
            } catch {
                print(error)
            }
        }
    }
    
    private func download(search: String? = nil) async throws -> [Game] {
        return try await GamesRouter().getGames(
            search: search ?? self.search,
            pagination: pagination
        ).results
    }
    
    func check(game: Game) {
        if let index = games.lastIndex(where: {$0 == game}),
            index > games.count - 5 {
            pagination.increasePage()
            
            fetchGames()
        }
    }
    
}
