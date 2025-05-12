//
//  CatListViewModel.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import Foundation

enum ViewState {
  case loading
  case error
  case loaded
}

protocol CatListViewModelAction: ObservableObject {
  func getCatList(urlStr: String) async
  func fetchBreedImages(breedID: String, limit: Int) async
}

// MARK: - Cat List ViewModel Implementation
@MainActor
final class CatListViewModel: CatListViewModelAction, ObservableObject {
  
  @Published private(set) var viewState: ViewState = .loading
  @Published var catList: Cat = []
  @Published var breedImages: [ImageElement] = []
  @Published var errorMessage: String?
  private let repository: CatRepositoryProtocol
  
  init(repository: CatRepositoryProtocol) {
    self.repository = repository
  }
  
  func getCatList(urlStr: String) async {
    viewState = .loading
    do {
      let list = try await repository.fetchCats(from: urlStr)
      catList = list
      viewState = .loaded
    } catch {
      viewState = .error
    }
  }
  
  func fetchBreedImages(breedID: String, limit: Int) async  {
    
    do {
      let images = try await repository.fetchBreedImages(breedID: breedID, limit: limit)
      self.breedImages = images
    } catch {
      self.errorMessage = "Failed to fetch images: \(error.localizedDescription)"
    }
  }
}
