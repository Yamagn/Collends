//
//  DecodableDataParser.swift
//  collends
//
//  Created by ymgn on 2019/08/20.
//  Copyright © 2019 ymgn. All rights reserved.
//

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
