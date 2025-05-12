//
//  MockRepository.swift
//  CatImageDemoTests
//
//  Created by MohammadHossan on 10/05/2025.
//

import Foundation
@testable import CatImageDemo

class MockCatRepository: CatRepositoryProtocol {
  
  var mockImages: [ImageElement]
  var errorToThrow: Error?
  
  init(mockImages: [ImageElement] = [], errorToThrow: Error? = nil) {
    self.mockImages = mockImages
    self.errorToThrow = errorToThrow
  }
  
  func fetchBreedImages(breedID: String, limit: Int = 1) async throws -> [CatImageDemo.ImageElement] {
    if let error = errorToThrow {
      throw error
    }
    return mockImages
  }
  
  func fetchCats(from urlString: String) async throws -> CatImageDemo.Cat {
    
    do {
      guard let fileName = URL(string: urlString)?.lastPathComponent else {
        throw NetworkError.invalidURL(urlString)
      }
      let bundle = Bundle(for: type(of: self))
      guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
        throw NetworkError.invalidURL(fileName)
      }
      
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let lists = try decoder.decode(Cat.self, from: data )
      return lists
    } catch {
      throw NetworkError.parsingError
    }
  }
}
