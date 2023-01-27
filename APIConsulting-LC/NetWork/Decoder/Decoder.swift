//
//  Decoder.swift
//  APIConsulting-LC
//
//  Created by u633168 on 27/01/2023.
//

import Foundation
final class DateDecoder: JSONDecoder {
    
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        // "2020-10-10T03:50:06.151+05:30"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
    
}
