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
}

// MARK: - Cat List ViewModel Implementation
@MainActor
final class CatListViewModel: CatListViewModelAction, ObservableObject {
  
  @Published private(set) var viewState: ViewState = .loading
  @Published var catList: Cat = []
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
}
