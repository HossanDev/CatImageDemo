//
//  CatImageDemoApp.swift
//  CatImageDemo
//
//  Created by MohammadHossan on 09/05/2025.
//

import SwiftUI

@main
struct CatImageDemoApp: App {
    var body: some Scene {
        WindowGroup {
          CatListView(viewModel: CatListViewModel(repository: CatRepository(networkService: NetworkManager())))
        }
    }
}
