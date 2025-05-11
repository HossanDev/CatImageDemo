//
//  EndPoint.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

struct EndPoint {
  static let baseURL =
  "https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1&include_breeds=5&api_key=\(SecretKey.catApiKey)"
  
  static func breedURL(breedID: String, limit: Int) -> String {
    return "https://api.thecatapi.com/v1/images/search?limit=\(limit)&breed_ids=\(breedID)&api_key=\(SecretKey.catApiKey)"
  }
}
