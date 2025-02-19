//
//  ListView.swift
//  SwiftUI_mgr
//
//  Created by Łukasz Czapkowski on 02/01/2025.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var viewModel: ListViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            if !viewModel.games.isEmpty{
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.games) { game in
                            ListCellView(viewModel: .init(game: game))
                                .onAppear {
                                    viewModel.check(game: game)
                                }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .background(Color.background)
                
                SearchView(search: $viewModel.search)
            } else if !viewModel.isLoading {
                Button(action: {
                    viewModel.fetchGames()
                }) {
                    Text("Spróbuj ponownie")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Text("dupa")
            }
        }
        .background(Color.background)
    }
}

#Preview {
    ListView()
}
