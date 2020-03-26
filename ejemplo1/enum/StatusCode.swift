//
//  StatusCode.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/26/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation

enum StatusCode: Int {
    case OK = 200
    case CREATED = 201
    case BAD_REQUEST = 400
    case UNAUTHORIZED = 401
    case NOT_FOUND = 404
    case CONFLICT = 409
}
