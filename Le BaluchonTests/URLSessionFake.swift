//
//  URLSessionFake.swift
//  Le BaluchonTests
//
//  Created by Sam on 20/07/2022.
//

import Foundation
import UIKit

class URLProtocolFake: URLProtocol
{
    static var data: Data?
    static var response: URLResponse?
    static var error: Error?
    
    static var requestHandler: ((URLRequest) throws -> (Data?, URLResponse?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true // Check if can handle the given request
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request // 
    }
    
    override func startLoading() {
        guard let handler = URLProtocolFake.requestHandler else {
            return
        }
        
        do {
            let (data, response, error) = try handler(request)
            if let response = response  {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
           }
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        
    }
    
    override func stopLoading() {
        
    }
    
    
}

//class URLSessionFake: URLSession
//{
//    var data: Data?
//    var response: URLResponse?
//    var error: Error?
//    
//    init(data: Data?, response: URLResponse?, error: Error?)
//    {
//        self.data = data
//        self.response = response
//        self.error = error
//    }
//    
//    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//    {
//        let task = URLSessionDataTaskFake()
//        task.completionHandler = completionHandler
//        task.data = data
//        task.urlResponse = response
//        task.responseError = error
//        return task
//    }
//    
//    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//    {
//        let task = URLSessionDataTaskFake()
//        task.completionHandler = completionHandler
//        task.data = data
//        task.urlResponse = response
//        task.responseError = error
//        return task
//    }
//}

class URLSessionDataTaskFake: URLSessionDataTask
{
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override init()
    {
    }
    
    override func resume()
    {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
}
