//
//  Extensions.swift
//  Weather
//
//  Created by Marcelo on 2023-09-09.
//

import Foundation

extension String {
    func encodeCity(_ string: String) -> String {
        string.replacingOccurrences(of: " ", with: "+")
    }
}
