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
  var catRepository: CatRepositoryProtocol?
  
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
    
    let mockRepository = MockCatRepository(mockImages: mockImages)
    
    // WHEN
    let breedImages = try await mockRepository.fetchBreedImages(breedID: "mock123", limit: 1)
    
    // THEN
    XCTAssertEqual(breedImages.count, 1)
    XCTAssertEqual(breedImages.first?.id, "mock123")
    XCTAssertEqual(breedImages.first?.url, "https://example.com/image.jpg")
  }
  
  func test_FetchBreedImages_Failure_Case() async {
    // GIVEN
    let expectedError = URLError(.notConnectedToInternet)
    let mockRepository = MockCatRepository(errorToThrow: expectedError)
    
    do {
      _ = try await mockRepository.fetchBreedImages(breedID: "mock123", limit: 1)
      XCTFail("Expected error but got success")
    } catch {
      XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
    }
  }
}
