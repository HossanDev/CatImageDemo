//
//  Cat.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

// MARK: - CatElement
struct CatElement: Codable {
  let breeds: [Breeds]
  let id: String
  let url: String
  let width, height: Int
}

typealias Cat = [CatElement]

// MARK: - BreedElement
struct Breeds: Codable {
  let weight: Weight
  let id, name: String
  let temperament: String
  let description: String
}

// MARK: - Weight
struct Weight: Codable {
  let imperial, metric: String
}
// MARK: - Image Element
struct ImageElement: Codable, Identifiable {
    let id: String
    let url: String
    let width, height: Int
}
