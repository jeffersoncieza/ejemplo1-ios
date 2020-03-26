//
//  ApiDeserializer.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/26/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiDeserializer {
    
    static func object<T: Decodable>(data: Data) -> T? {
        do {
            let responseJSON = try JSON(data: data)
            return ApiDeserializer.object(json: responseJSON)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    static func object<T: Decodable>(json: JSON) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: json.rawData())
        } catch let error {
            print(error)
            return nil
        }
    }
    
    static func array<T: Decodable>(json: JSON) -> [T]? {
        do {
            return try JSONDecoder().decode([T].self, from: json.rawData())
        } catch let error {
            print(error)
            return nil
        }
    }
    
    static func pageable<T: Decodable>(json: JSON) -> Pageable<T>? {
        do {
            let items = try JSONDecoder().decode([T].self, from: json["content"].rawData())
            return Pageable(items, json["last"].bool!, json["number"].int!)
        } catch let error {
            print(error)
            return nil
        }
    }
}
