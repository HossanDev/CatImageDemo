//
//  MockRepository.swift
//  CatImageDemoTests
//
//  Created by MohammadHossan on 10/05/2025.
//

import Foundation
@testable import CatImageDemo

class MockCatRepository: CatRepositoryProtocol {
  
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
