//
//  ListCellView.swift
//  SwiftUI_mgr
//
//  Created by Łukasz Czapkowski on 02/01/2025.
//

import SwiftUI
import Kingfisher

struct ListCellView: View {
    
    let viewModel: ListCellViewModel
    
    var body: some View {
        NavigationStack {
            NavigationLink(
                destination: DetailsView(
                    viewModel: .init(game: viewModel.game)
                )
            ) {
                VStack{
                    KFImage(.init(string: viewModel.game.backgroundImage ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        platforms
                        
                        HStack(alignment: .center) {
                            Text(viewModel.game.name)
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            MetacriticScoreView(rating: viewModel.game.metacritic)
                        }
                        
                        HStack {
                            Text("Data wydania:")
                            Spacer()
                            Text(viewModel.game.released ?? "")
                        }
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.white)
                    }
                    .padding(16)
                }
                .background(Color.cellBackground)
                .cornerRadius(32)
            }
        }
    }
    
    @ViewBuilder
    private var platforms: some View {
        if let parentPlatforms = viewModel.game.parentPlatforms {
            HStack {
                ForEach(parentPlatforms, id: \.platform.id) { parentPlatform in
                    PlatformView(platform: .init(rawValue: parentPlatform.platform.id) ?? .ps5)
                }
            }
        }
    }
}

//#Preview {
//    ListCellView()
//}
