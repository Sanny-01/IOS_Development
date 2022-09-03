//
//  APIError.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 30.08.22.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case httpError
    case decodingError
}
