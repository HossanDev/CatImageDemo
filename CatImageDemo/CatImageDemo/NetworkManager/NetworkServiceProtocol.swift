//
//  NetworkServiceProtocol.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

protocol NetworkServiceProtocol {
  func request(from urlString: String) async throws -> Data
  func requestBreedImages(breedID: String, limit: Int) async throws -> Data
}
