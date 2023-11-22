//
//  FirebaseRemoteConfigControl.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import FirebaseRemoteConfig

public protocol FirebaseRemoteConfigWorker {
    func fetchData(completion: @escaping (Result<Books, Error>) -> Void)
}

public protocol FirebaseRemoteConfigWorkerContainer {
    var firebaseRemoteConfigWorker: FirebaseRemoteConfigWorker { get }
}

private enum Key: String {
    case remoteConfigKey = "json_data"
    case topBannerSlides = "top_banner_slides"

    var value: String {
        rawValue
    }
}

public final class FirebaseRemoteConfigControl: FirebaseRemoteConfigWorker {

    private let remoteConfig: RemoteConfig = {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        $0.configSettings = settings
        return $0
    }(RemoteConfig.remoteConfig())

    public init() {}

    public func fetchData(completion: @escaping (Result<Books, Error>) -> Void) {
        remoteConfig.fetch { [weak self] status, error in
            guard let self else { return }
            if status == .success {
                do {
                    if let error {
                        throw NetworkError.activatedError(description: error.localizedDescription)
                    }

                    guard let jsonValue = self.remoteConfig
                        .configValue(
                            forKey: Key.remoteConfigKey.value).jsonValue else {
                        throw NetworkError.jsonNil
                    }

                    guard let dictionary = jsonValue as? [String: Any] else {
                        throw NetworkError.failedConvert
                    }

                    guard JSONSerialization.isValidJSONObject(dictionary) else {
                        throw NetworkError.invalidJSONStucture
                    }

                    let data = try JSONSerialization.data(withJSONObject: dictionary)
                    let decodedData = try JSONDecoder().decode(Books.self, from: data)

                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
