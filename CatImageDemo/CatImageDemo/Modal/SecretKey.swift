//
//  SecretKey.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 10/05/2025.
//

import Foundation
enum SecretKey {
  static var catApiKey: String {
    Bundle.main.infoDictionary?["CAT_API_KEY"] as? String ?? ""
  }
}
