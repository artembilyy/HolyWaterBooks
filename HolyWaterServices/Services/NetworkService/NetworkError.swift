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
    case statusNotSuccess
    case invalidURL
    case noImage
    case unknown
    /// description
    public var description: String {
        switch self {
        case .activationFailed:
            return "Activation failed"
        case .activatedError(let description):
            return "Catch an error while activating \(description)"
        case .jsonNil:
            return "JSON nil"
        case .invalidJSONStucture:
            return "Invalid JSON structure"
        case .statusNotSuccess:
            return "Remote config status not success"
        case .invalidURL:
            return "Invalid URL"
        case .noImage:
            return "Image failure"
        default:
            return "Unknown error"
        }
    }
}
