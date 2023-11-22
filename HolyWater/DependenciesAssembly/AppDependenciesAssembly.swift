//
//  AppDependenciesAssembly.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import HolyWaterServices

final class AppDependenciesAssembly {

    typealias AppDependencies =
        CrashAnalyticReporterContainer &
        FirebaseRemoteConfigWorkerContainer

    struct DependenciesContainer: AppDependencies {
        let crashAnalyticReporter: CrashAnalyticReporter
        let firebaseRemoteConfigWorker: FirebaseRemoteConfigWorker
    }

    func assembleDependencies() -> DependenciesContainer {
        .init(
            crashAnalyticReporter: CrashAnalytics(),
            firebaseRemoteConfigWorker: FirebaseRemoteConfigControl())
    }
}
