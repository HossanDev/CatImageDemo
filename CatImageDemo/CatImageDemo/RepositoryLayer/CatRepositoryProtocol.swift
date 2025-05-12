//
//  CatRepositoryProtocol.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

protocol CatRepositoryProtocol {
  func fetchCats(from urlString: String) async throws -> Cat
  func fetchBreedImages(breedID: String, limit: Int) async throws -> [ImageElement]
}

