//
//  JSONEncoder+ISODate.swift
//  SmartMed
//
//  Created by Pedro Lopes on 07/09/2018.
//  Copyright © 2018 SmartMed. All rights reserved.
//

import Foundation

extension JSONEncoder {
    class func JSONEncoderISODate() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}
