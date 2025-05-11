//
//  CatAsyncImageView.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import SwiftUI

struct CatAsyncImageView: View {
  
  let url: URL
  private let imageWidth = 250.0
  private let cellHeight = 250.0
  
  var body: some View {
    CacheAsyncImage(
      url: url) { phase in
        switch phase {
        case .success(let image):
          VStack {
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: imageWidth)
              .padding(.trailing, 10)
            Spacer()
          }
        case .failure:
          Image(systemName: "pencil.line")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageWidth)
            .padding(.trailing, 10)
          
        case .empty:
          HStack(alignment: .center) {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .red))
          }
        @unknown default:
          Image(systemName: "pencil.line")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageWidth)
            .padding(.trailing, 10)
        }
      }
   }
}

