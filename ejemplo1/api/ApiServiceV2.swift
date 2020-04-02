//
//  ApiServiceV2.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/29/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation

class ApiServiceV2: NSObject {
    
    static let sharedInstance = ApiServiceV2()
    
    func listPerson(_ completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: ApiConstant.LIST_PERSON)!
        request(url, completion)
    }
    
    func createPerson(_ dto: PersonDto, _ completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        guard let uploadData = try? JSONEncoder().encode(dto) else {
            return
        }
        
        let url = URL(string: ApiConstant.CREATE_PERSON)!
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request(req, uploadData, completion)
    }
    
    
    
    
    
    
    
    
    
    
    private func request(_ url: URL, _ completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print("Error occurred: \(err)")
                completion(nil, nil, err)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(response)")
                completion(nil, response, error)
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion(data, httpResponse, nil)
                }
            }
        }
        task.resume()
    }
    
    private func request(_ request: URLRequest, _ uploadData: Data, _ completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let err = error {
                print("Error occurred: \(err)")
                completion(nil, nil, err)
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(response)")
                completion(nil, response, error)
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion(data, httpResponse, nil)
                }
            }
        }
        task.resume()
    }
}
