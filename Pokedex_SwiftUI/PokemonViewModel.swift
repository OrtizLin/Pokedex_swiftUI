//
//  PokemonViewModel.swift
//  Pokedex_SwiftUI
//
//  Created by Otis on 2024/9/13.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellable: AnyCancellable?
    
    func fetchPokemon(name: String) {
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] pokemon in
                self?.pokemon = pokemon
            })
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func formattedHeight() -> String {
        guard let height = pokemon?.height else { return "-" }
        return String(format: "%.1f m", height / 10.0)
    }
    
    func formattedWeight() -> String {
        guard let weight = pokemon?.weight else { return "-" }
        return String(format: "%.1f kg", weight / 10.0)
    }
    
    func formattedID() -> String {
        guard let id = pokemon?.id else { return "-" }
        return String(format: "#%03d", id)
    }
}
