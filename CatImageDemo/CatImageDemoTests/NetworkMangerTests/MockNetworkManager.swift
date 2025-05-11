//
//  MockNetworkManager.swift
//  CatImageDemoTests
//
//  Created by MohammadHossan on 10/05/2025.
//

import Foundation
@testable import CatImageDemo

class MockNetworkManager: NetworkServiceProtocol {
  
  func request(from urlString: String) async throws -> Data {
    
    guard let fileName = URL(string: urlString)?.lastPathComponent else {
      throw NetworkError.invalidURL(urlString)
    }
    let bundle = Bundle(for: type(of: self))
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
      throw NetworkError.invalidURL(fileName)
    }
    
    do {
      let data = try Data(contentsOf: url)
      return data
    } catch {
      throw NetworkError.invalidResponse
    }
  }
}
