//
//  MockImageLoader.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 10/05/2025.
//

import Foundation
@testable import CatImageDemo

class MockImageLoader: FetchBreedImages {
  var mockImages: [ImageElement]
  var errorToThrow: Error?

  init(mockImages: [ImageElement] = [], errorToThrow: Error? = nil) {
    self.mockImages = mockImages
    self.errorToThrow = errorToThrow
  }

  func fetchBreedImages(breedID: String, limit: Int = 1) async throws -> [ImageElement] {
    if let error = errorToThrow {
      throw error
    }
    return mockImages
  }
}

