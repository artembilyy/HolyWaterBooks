//
//  PerformAsyncOperation.swift
//  HolyWaterUI
//
//  Created by Artem Bilyi on 09.02.2024.
//

public protocol AsyncOperation {
    func performAsyncOperation<T>(
        task: @escaping () async throws -> T,
        completion: @escaping (T?) -> Void)
}

public extension AsyncOperation {
    @MainActor
    func performAsyncOperation<T>(
        task: @escaping () async throws -> T,
        completion: @escaping (T?) -> Void) {
        Task {
            do {
                let result = try await task()
                completion(result)
            } catch {
                completion(nil)
            }
        }
    }
}
