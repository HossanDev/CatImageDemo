//
//  CatViewModelTest.swift
//  CatImageDemoTests
//
//  Created by MohammadHossan on 10/05/2025.
//

import XCTest
@testable import CatImageDemo

final class CatViewModelTest: XCTestCase {
  
  var mockRepository: MockCatRepository?
  var catListViewModel: CatListViewModel?
  
  @MainActor
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    mockRepository = MockCatRepository()
    catListViewModel = CatListViewModel(repository: mockRepository ?? MockCatRepository())
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    mockRepository = nil
    catListViewModel = nil
  }
  
  func test_Get_Cat_In_Success_Case() async throws {
    
    // GIVEN
    await catListViewModel?.getCatList(urlStr: "CatImageMockData")
    
    // WHEN
    let catList = await catListViewModel?.catList
    guard let catList = catList else {
      XCTFail("Cat is nil")
      return
    }
    
    //THEN
    XCTAssertNotNil(catList)
    XCTAssertTrue(catList.count > 0)
    XCTAssertEqual(catList.first?.id, "Z6mrcccZv")
  }
  
  func test_Get_Cat_In_Failure_Case() async throws {
    
    // GIVEN
    await catListViewModel?.getCatList(urlStr: "EmptyMockData")
    
    // WHEN
    let catList = await catListViewModel?.catList
    guard let catList = catList else {
      XCTFail("Cat is nil")
      return
    }
    
    //THEN
    XCTAssertNotNil(catList)
    XCTAssertTrue(catList.isEmpty)
    XCTAssertEqual(catList.first?.id, nil)
  }
}
