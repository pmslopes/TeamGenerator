//
//  JSONDecoderExtension.swift
//  SmartMed
//
//  Created by Pedro Lopes on 07/09/2018.
//  Copyright © 2018 SmartMed. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    class func JSONDecoderISODate() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
}
