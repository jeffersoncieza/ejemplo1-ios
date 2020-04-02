//
//  ApiService.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/26/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func listPerson(_ completion: @escaping (Error?, Int, JSON?) -> ()) {
        request(url: ApiConstant.LIST_PERSON, httpMethod: HTTPMethod.get, parameters: nil, headers: nil, completion: completion)
    }
    
    func createPerson(_ parameters: Parameters, _ completion: @escaping (Error?, Int, JSON?) ->()) {
        print("plop")
        request(url: ApiConstant.CREATE_PERSON, httpMethod: HTTPMethod.post, parameters: parameters, headers: nil, completion: completion)
    }
    
    // MARK: - Request for all methods
    func request(url: String, httpMethod: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?,
                 encoding: ParameterEncoding? = JSONEncoding.default, completion: @escaping (Error?, Int, JSON?) -> ()) {
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: encoding!, headers: headers)
            .responseJSON { (dataResponse) in
                if let error = dataResponse.error {
                    DispatchQueue.main.async {
                        completion(error, dataResponse.response?.statusCode ?? -1, nil)
                        return
                    }
                }
                
                if let data = dataResponse.data, let json = try? JSON.init(data: data),
                    let statusCode = dataResponse.response?.statusCode {
                    DispatchQueue.main.async {
                        completion(nil,statusCode,json)
                    }
                }
        }
    }
    
    func request(url: String, httpMethod: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?,
                 encoding: ParameterEncoding? = JSONEncoding.default, completion: @escaping (DataResponse<String>?, Int, Int?) -> ()) {
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: encoding!, headers: headers)
            .responseString { (dataResponse) in
                if let error = dataResponse.error {
                    DispatchQueue.main.async {
                        completion(nil, dataResponse.response?.statusCode ?? -1, nil)
                        return
                    }
                }
                
                if let data = dataResponse.data, let statusCode = dataResponse.response?.statusCode {
                    DispatchQueue.main.async {
                        completion(dataResponse.self, statusCode, Int(String(data: data, encoding: .utf8)!))
                    }
                }
        }
    }
    
    func request(url: String, httpMethod: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?,
                 encoding: ParameterEncoding? = JSONEncoding.default, completion: @escaping (Error?, Int, String?) -> ()) {
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: encoding!, headers: headers)
            .responseString { (dataResponse) in
                if let error = dataResponse.error {
                    DispatchQueue.main.async {
                        completion(error, dataResponse.response?.statusCode ?? -1, nil)
                        return
                    }
                }
                
                if let data = dataResponse.data, let statusCode = dataResponse.response?.statusCode {
                    DispatchQueue.main.async {
                        completion(nil,statusCode, String(data: data, encoding: .utf8)!)
                    }
                }
        }
    }
}
