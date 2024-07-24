//
//  NetworkingLayerExampleTests.swift
//  NetworkingLayerExampleTests
//
//  Created by Lorenzo Brown on 7/23/24.
//
@testable import NetworkingLayerExample
//import Testing
import Foundation
import XCTest

class MockURLSession:  URLSession, @unchecked Sendable   {
    var data: Data?
    var error: Error?
    
    override init() {
        super.init()
    }
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

final class NetworkingLayerExampleTests: XCTestCase {
    func testPerformRequestSuccess() {
            let expectedData = "{\"key\":\"value\"}".data(using: .utf8)!
            let mockSession = MockURLSession(data: expectedData, error: nil)
            let networkingLayer = NetworkingLayer(session: mockSession)
            
            let request = AssetsRequest()
            let exp = expectation(description: "Loading stories")

            networkingLayer.performRequest(request) { (result: Result<Dictionary<String, String>, NetworkError>) in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data["key"], "value")
                case .failure:
                    XCTFail("Expected success, but got failure")
                }
                exp.fulfill()
            }
            
            waitForExpectations(timeout: 1, handler: nil)
        }
        
        func testPerformRequestFailure() {
            let mockSession = MockURLSession(data: nil, error: NetworkError.requestFailed)
            let networkingLayer = NetworkingLayer(session: mockSession)
            
            let request = AssetsRequest()
            
            let expectation = self.expectation(description: "Completion handler invoked")
            
            networkingLayer.performRequest(request) { (result: Result<Dictionary<String, String>, NetworkError>) in
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertEqual(error, .requestFailed)
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 1, handler: nil)
        }

}
