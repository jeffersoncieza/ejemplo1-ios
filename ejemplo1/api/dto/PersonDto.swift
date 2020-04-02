//
//  PersonDto.swift
//  ejemplo1
//
//  Created by Jeferson Cieza on 4/1/20.
//  Copyright © 2020 Jeferson Cieza. All rights reserved.
//

import Foundation

struct PersonDto: Encodable {
    
    let name: String
    let title: String
    let salary: Double
    
    init(_ name: String, _ title: String, _ salary: Double) {
        self.name = name
        self.title = title
        self.salary = salary
    }
}
