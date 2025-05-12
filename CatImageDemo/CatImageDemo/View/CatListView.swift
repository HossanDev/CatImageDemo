//
//  CatListImageView.swift.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import SwiftUI

struct CatListView: View {
  // MARK: - Using State Object to make sure view model object will not destroyed or recreate.
  @StateObject var viewModel: CatListViewModel
  @State private var isErrorOccured = true
  @State private var isBreedViewActive = false
  @State private var selectedBreed: Breeds?
  
  var body: some View {
    NavigationStack {
      VStack {
        switch viewModel.viewState {
        case .loading:
          ProgressView()
        case .loaded:
          if let cat = viewModel.catList.first,
             let breed = cat.breeds.first {
            Button {
              selectedBreed = breed
              isBreedViewActive = true
            } label: {
              CatImageView(url: cat.url)
            }
          }
        case .error:
          showErrorView()
        }
      }
      .padding(.top, 40)
      Spacer()
      buttonView()
        .padding(.vertical, 80)
        .navigationDestination(isPresented: $isBreedViewActive) {
          if let breed = selectedBreed {
            CatBreedView(breed: breed, viewModel: viewModel)
          }
        }
        .navigationTitle(Text(LocalizedStringKey("Cat Image")))
    }.task {
      await viewModel.getCatList(urlStr: EndPoint.baseURL)
    }
  }
  
  // MARK: - Using ViewBuilder to create the child view.
  @ViewBuilder
  func showErrorView() -> some View {
    ProgressView().alert(isPresented: $isErrorOccured) {
      Alert(title: Text("Error Occured"),message: Text("Something went wrong"), dismissButton: .default(Text("Ok")))
    }
  }
  
  @ViewBuilder
  func buttonView() -> some View {
    VStack {
      Button {
        Task {
          await viewModel.getCatList(urlStr: EndPoint.baseURL)
        }
      } label: {
        Text("Next Cat")
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(12)
          .padding(.horizontal)
      }
    }
  }
}

#Preview {
  CatListView(viewModel: CatListViewModel(repository: CatRepository(networkService: NetworkManager())))
}
