//
//  ContentView.swift
//  Pokedex_SwiftUI
//
//  Created by Otis on 2024/9/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let pokemon = viewModel.pokemon {
                VStack(spacing: 10) {
                    if let imageUrl = URL(string: pokemon.sprites.other.home.frontDefault) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 366, height: 365)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 0.87, green: 0.88, blue: 0.9), lineWidth: 2)
                                )
                                .padding(0)
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    HStack(spacing: 0) {
                        // Left section for basic information
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name: \(pokemon.name.capitalized)")
                                .font(.custom("Manrope-Bold", size: 16))
                            
                            Text("Height: \(viewModel.formattedHeight())")
                                .font(.custom("Manrope-Bold", size: 16))
                            
                            Text("Weight: \(viewModel.formattedWeight())")
                                .font(.custom("Manrope-Bold", size: 16))
                            
                            Text("ID: \(viewModel.formattedID())")
                                .font(.custom("Manrope-Bold", size: 16))
                        }
                        .padding(12)
                        .frame(width: 177, height: 365, alignment: .topLeading)
                        .background(Color(red: 0.87, green: 0.88, blue: 0.9))
                        .cornerRadius(8, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])

                        // Right section for Types
                        VStack(alignment: .leading, spacing: 4) {
                            Text("特性")
                                .font(.custom("Manrope-Bold", size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading) // Align to the top-left corner
                            
                            ForEach(pokemon.types, id: \.type.name) { typeEntry in
                                Text(typeEntry.type.name)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(UIColor.systemGray4))
                                    .cornerRadius(12)
                                    .font(.custom("Manrope-Bold", size: 16))
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(12)
                        .frame(width: 177, height: 365, alignment: .topLeading) // Align content to top-left
                        .background(Color.clear)
                        .cornerRadius(8, corners: [.topRight])
                    }
                    .background(Color.white)
                }
                .padding(0)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                Text("No data")
            }
        }
        .onAppear {
            viewModel.fetchPokemon(name: "gengar")
        }
    }
}


#Preview {
    ContentView()
}
