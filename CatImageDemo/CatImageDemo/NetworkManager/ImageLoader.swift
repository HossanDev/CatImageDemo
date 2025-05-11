//
//  ImageLoader.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 10/05/2025.
//

import Foundation

protocol FetchBreedImages {
  func fetchBreedImages(breedID: String, limit: Int) async throws -> [ImageElement]
}

class ImageLoader: FetchBreedImages {
  
  func fetchBreedImages(breedID: String, limit: Int = 4) async throws -> [ImageElement] {
    let urlString = EndPoint.breedURL(breedID: breedID, limit: limit)
    
    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL(urlString)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([ImageElement].self, from: data)
  }
}
