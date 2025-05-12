//
//  CatRepository.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

struct CatRepository: CatRepositoryProtocol {
  private let networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol = NetworkManager()) {
    self.networkService = networkService
  }
  
  func fetchCats(from urlString: String) async throws -> Cat {
    let data = try await networkService.request(from: urlString)
    
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return try decoder.decode(Cat.self, from: data)
    } catch {
      throw NetworkError.decodingFailed(error)
    }
  }
  
  func fetchBreedImages(breedID: String, limit: Int) async throws -> [ImageElement] {
    
    let data = try await networkService.requestBreedImages(breedID: breedID, limit: limit)
    let catImages = try JSONDecoder().decode([ImageElement].self, from: data)
    return catImages
  }
}

