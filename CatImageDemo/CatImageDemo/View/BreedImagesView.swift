//
//  BreedImagesView.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 10/05/2025.
//
import SwiftUI

struct BreedImagesView: View {
  
  let breedID: String
  private let imageLoader = ImageLoader()
  @State private var imageElements: [ImageElement] = []
  @State private var errorMessage: String?
  
  var body: some View {
    VStack {
      contentView
    }
    .navigationTitle("Breed Images")
    .task {
      await fetchBreedImages(append: false)
    }
  }
  
  private var contentView: some View {
    Group {
      if isLoading {
        ProgressView("Loading Images...")
          .progressViewStyle(CircularProgressViewStyle())
      } else if let error = errorMessage {
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
        ForEach(imageElements) {
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
          await fetchBreedImages(append: true)
        }
      } label: {
        Text("load more breed image")
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
    imageElements.isEmpty && errorMessage == nil
  }
  
  private func fetchBreedImages(append: Bool) async {
    do {
      let images = try await imageLoader.fetchBreedImages(breedID: breedID)
      if append {
        let newImages = images.filter { newBreedImage in
          !imageElements.contains(where: { $0.id == newBreedImage.id })
        }
        imageElements.append(contentsOf: newImages)
      } else {
        imageElements = images
      }
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}

#Preview {
  BreedImagesView(breedID: "test")
}
