//
//  NetworkManager.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

struct NetworkManager: NetworkServiceProtocol {
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func request(from urlString: String) async throws -> Data {
    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL(urlString)
    }
    do {
      let (data, response) = try await session.data(from: url)
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        throw NetworkError.invalidResponse
      }
      return data
    } catch {
      throw NetworkError.requestFailed(error)
    }
  }
}

