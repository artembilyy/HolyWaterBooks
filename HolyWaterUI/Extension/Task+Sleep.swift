//
//  Task+Sleep.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

public extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
