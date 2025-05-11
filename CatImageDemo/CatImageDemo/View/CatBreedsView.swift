//
//  CatBreedsView.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//
import SwiftUI

struct CatBreedView: View {
  let breed: Breeds
  @State private var imageElements: [ImageElement] = []
  @State private var errorMessage: String?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Name: \(breed.name)")
        .font(.title3)
        .bold()
      
      Text("Temperament: \(breed.temperament)")
        .font(.subheadline)
        .multilineTextAlignment(.leading)
      
      BreedImagesView(breedID: breed.id)
    }
    .padding(.top, 30)
    .padding(.horizontal)
    .navigationTitle("Breed")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  CatBreedView(
    breed: Breeds(
      weight: Weight(
        imperial: "10",
        metric: "10"),
      id: "10",
      name: "Test",
      temperament: "10",
      description: "test"))
}
