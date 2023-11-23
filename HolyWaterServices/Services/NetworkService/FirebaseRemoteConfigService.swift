//
//  FirebaseRemoteConfigService.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import FirebaseRemoteConfig

public protocol FirebaseRemoteConfigWorker {
    func fetchData(completion: @escaping (Result<BookResponse, NetworkError>) -> Void)
}

public protocol FirebaseRemoteConfigWorkerContainer {
    var firebaseRemoteConfigWorker: FirebaseRemoteConfigWorker { get }
}

private enum Key: String {
    case remoteConfigKey = "json_data"

    var value: String {
        rawValue
    }
}

public final class FirebaseRemoteConfigService: FirebaseRemoteConfigWorker {

    private let remoteConfig: RemoteConfig = {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        $0.configSettings = settings
        return $0
    }(RemoteConfig.remoteConfig())

    public init() {}

    public func fetchData(completion: @escaping (Result<BookResponse, NetworkError>) -> Void) {
        remoteConfig.fetch { [weak self] status, error in
            guard let self else { return }
            guard status == .success, error == nil else {
                print("Error fetching remote config: \(String(describing: error))")
                completion(.failure(NetworkError.statusNotSuccess))
                return
            }

            self.remoteConfig.activate { _, _ in
                guard
                    let jsonString = self.remoteConfig["json_data"].stringValue,
                    let jsonData = jsonString.data(using: .utf8)
                else {
                    completion(.failure(NetworkError.jsonNil))
                    return
                }

                do {
                    let data = try JSONDecoder().decode(BookResponse.self, from: jsonData)
                    completion(.success(data))
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(
                        .failure(NetworkError.jsonDecodingFailure(description: error.localizedDescription))
                    )
                }
            }
        }
    }
}
