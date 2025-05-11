//
//  CatImageView.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import SwiftUI

struct CatImageView: View {
  let url: String?
  
  var body: some View {
    HStack {
      if let url = URL(string: url ?? "Not Available") {
        CatAsyncImageView(url: url)
      }
    }
  }
}

#Preview {
  CatImageView(url: "https://cdn2.thecatapi.com/images/e3v.jpg")
}
