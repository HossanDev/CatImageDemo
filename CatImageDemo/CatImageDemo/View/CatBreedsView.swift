//
//  CatBreedsView.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//
import SwiftUI

struct CatBreedView: View {
  let breed: Breeds
  @StateObject private var viewModel: CatListViewModel
  
  init(breed: Breeds, viewModel: CatListViewModel) {
    self.breed = breed
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 10) {
        Text("Name: \(breed.name)")
          .font(.title3)
          .bold()
        
        Text("Temperament: \(breed.temperament)")
          .font(.subheadline)
          .multilineTextAlignment(.leading)
        
        contentView
      }
    }
    .padding(.top, 30)
    .padding(.horizontal)
    .navigationTitle("Breed Details view")
    .navigationBarTitleDisplayMode(.inline)
    .task {
      await fetchBreedImages()
    }
  }
  
  private var contentView: some View {
    Group {
      if isLoading {
        ProgressView("Loading Images...")
          .progressViewStyle(CircularProgressViewStyle())
      } else if let error = viewModel.errorMessage {
        Text("Error: \(error)")
          .foregroundColor(.red)
          .padding()
      } else {
        VStack {
          catBreedImagesView
          loadMoreBreedImageButton()
        }
      }
    }
  }
  
  private var catBreedImagesView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 20) {
        ForEach(viewModel.breedImages) {
          if let imageURL = URL(string: $0.url) {
            CatAsyncImageView(url: imageURL)
              .frame(width: 180, height: 180)
          } else {
            fallbackImageView
          }
        }
      }
      .padding()
    }
  }
  
  private func loadMoreBreedImageButton() -> some View {
    VStack {
      Button {
        Task {
          await fetchBreedImages()
        }
      } label: {
        Text("load random breed image")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(12)
          .padding(.horizontal)
      }
    }
  }
  
  private var fallbackImageView: some View {
    Image(systemName: "photo")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 250, height: 250)
      .cornerRadius(8)
  }
  
  private var isLoading: Bool {
    viewModel.breedImages.isEmpty && viewModel.errorMessage == nil
  }
  
  private func fetchBreedImages() async {
    await viewModel.fetchBreedImages(breedID: breed.id, limit: 4)
  }
}

#Preview {
  CatBreedView(breed: Breeds(weight: Weight(imperial: "10", metric: "10"), id: "10", name: "Test", temperament: "10",
      description: "test"),
      viewModel: CatListViewModel(repository: CatRepository(networkService: NetworkManager())))
}
