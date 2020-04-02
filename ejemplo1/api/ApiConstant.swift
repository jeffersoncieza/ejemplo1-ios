//
//  ApiConstant.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/26/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation

class ApiConstant {
    
    private static let HOST = "http://192.168.0.4:8080"
    
    private static let VERSION = "/api/v1"
    private static let ROOT = HOST + VERSION
    private static let PUBLIC = "/public"
    private static let SECURED = "/secured"
    
    private static let ENDPOINT_PERSON = ROOT + PUBLIC + "/person"
    
    public static let LIST_PERSON = ENDPOINT_PERSON
    public static let CREATE_PERSON = ENDPOINT_PERSON
}
