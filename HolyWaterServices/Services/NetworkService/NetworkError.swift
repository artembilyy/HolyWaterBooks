//
//  NetworkError.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

public enum NetworkError: Error {
    case activationFailed
    case activatedError(description: String)
    case jsonNil
    case failedConvert
    case invalidJSONStucture
    case jsonDecodingFailure(description: String)

    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case noInternetConnection
    case unexpectedStatusCode
    case invalidURL
    case noImage
    case unknown
    /// description
    var description: String {
        switch self {
        case .activationFailed:
            return "Activation failed"
        case .activatedError(let description):
            return "Catch an error while activating \(description)"
        case .jsonNil:
            return "JSON nil"
        case .invalidJSONStucture:
            return "Invalid JSON structure"

        case .requestFailed(let description):
            return "Request failed: \(description)"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful(let description):
            return "Response unsuccessful: \(description)"
        case .jsonDecodingFailure(let description):
            return "Json deconing failure desription: \(description)"
        case .noInternetConnection:
            return "No internet connection"
        case .unexpectedStatusCode:
            return "Unexpected status code"
        case .invalidURL:
            return "Invalid URL"
        case .noImage:
            return "Image failure"
        default:
            return "Unknown error"
        }
    }
}
