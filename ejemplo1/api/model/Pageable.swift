//
//  Pageable.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 3/26/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation

class Pageable<T> {
    
    var items: [T]?
    var last: Bool?
    var page: Int?
    
    init(_ items: [T], _ last: Bool, _ page: Int) {
        self.items = items
        self.last = last
        self.page = page
    }
}
