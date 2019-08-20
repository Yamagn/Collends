//
//  API.swift
//  collends
//
//  Created by ymgn on 2019/08/16.
//  Copyright © 2019 ymgn. All rights reserved.
//

import Foundation
import APIKit

protocol NASARequest: Request {
}

extension NASARequest {
    var baseURL: URL {
        return URL(string: "https://api.nasa.gov")!
    }
}

extension NASARequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

struct APOD: Decodable {
    let copylight: String?
    let date: String?
    let explanation: String
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let title: String?
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case copylight
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}

final class NASAAPI {
    private init() {}
    
    struct AstronomyPtictureOfTheDay: NASARequest {
        typealias Response = APOD
        
        let method: HTTPMethod = .get
        let path: String = "/planetary/apod"
        var parameters: Any? {
            return ["date": date, "api_key": APIKEY]
        }
        
        let date: String
    }
}
