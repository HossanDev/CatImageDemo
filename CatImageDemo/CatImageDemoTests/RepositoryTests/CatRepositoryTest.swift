//
//  CatRepositoryTest.swift
//  CatImageDemoTests
//
//  Created by MohammadHossan on 10/05/2025.
//

import XCTest
@testable import CatImageDemo

final class CatRepositoryTest: XCTestCase {
  
  var mockNetworkManager: MockNetworkManager?
  var catRepository: CatRepository?
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    mockNetworkManager = MockNetworkManager()
    catRepository = CatRepository(networkService: mockNetworkManager ?? MockNetworkManager())
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    mockNetworkManager = nil
    catRepository = nil
  }
  
  // when passes cat data return with some data
  func test_Get_Cat_In_Success_Case() async throws {
    
    // GIVEN
    let catList = try await catRepository?.fetchCats(from: "CatImageMockData")
    
    // WHEN
    guard let catList = catList else {
      XCTFail("Cat is nil")
      return
    }
    
    //THEN
    XCTAssertNotNil(catList)
    XCTAssertTrue(catList.count > 0)
    XCTAssertEqual(catList.first?.id, "Z6mrcccZv")
  }
  
  // when passes cat data return with empty data
  func test_Get_Cat_In_Failure_Case() async throws {
    
    // GIVEN
    let catList = try await catRepository?.fetchCats(from: "EmptyMockData")
    
    // WHEN
    guard let catList = catList else {
      XCTFail("Cat is nil")
      return
    }
    
    //THEN
    XCTAssertNotNil(catList)
    XCTAssertTrue(catList.isEmpty)
    XCTAssertEqual(catList.first?.id, nil)
  }
  
  func test_FetchBreedImages_Success_Case() async throws {
    
    // GIVEN
    let mockImages = [
      ImageElement(id: "mock123",
                   url: "https://example.com/image.jpg",
                   width: 400,
                   height: 300)
    ]
    
    // WHEN
    let mockImageLoader = MockImageLoader(mockImages: mockImages)
    guard let breedID = mockImages.first?.id else {
      XCTFail("Mock image ID is nil")
      return
    }
    
    let breedImages = try await mockImageLoader.fetchBreedImages(breedID: breedID)
    
    //THEN
    XCTAssertEqual(breedImages.count, 1)
    XCTAssertEqual(breedImages.first?.id, "mock123")
  }
  
  func test_ViewModel_FetchBreedImages_EmptyList() async throws {
    // GIVEN
    let mockImageLoader = MockImageLoader(mockImages: [])
    
    // WHEN
    let images = try await mockImageLoader.fetchBreedImages(breedID: "some_valid_breed_id")
    
    // THEN
    XCTAssertTrue(images.isEmpty, "Expected image list to be empty for breed ID")
  }
}
