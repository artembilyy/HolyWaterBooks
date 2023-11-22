//
//  FirebaseCrashAnalytics.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import FirebaseCrashlytics

public protocol CrashAnalyticReporter {
    func sendCrashReport(crash event: CrashAnalytics.CrashEvent, from source: String?)
}

public protocol CrashAnalyticReporterContainer {
    var crashAnalyticReporter: CrashAnalyticReporter { get }
}

public final class CrashAnalytics: CrashAnalyticReporter {

    public enum CrashEvent {
        case memoryWarning

        var description: String {
            switch self {
            case .memoryWarning:
                return "DidReceiveMemoryWarning()"
            }
        }
    }

    public init() {}

    public func sendCrashReport(crash event: CrashEvent, from source: String? = "") {
        Crashlytics.crashlytics().log("Crash: \(event.description). (Optionaly) from \(source ?? "unknown")")
    }
}
