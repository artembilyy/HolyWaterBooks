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
        FirebaseRemoteConfigWorkerContainer &
        ImageLoadingWorkerContrainer &
        RealmServiceWorkerContainer

    struct DependenciesContainer: AppDependencies {
        let crashAnalyticReporter: CrashAnalyticReporter
        let firebaseRemoteConfigWorker: FirebaseRemoteConfigWorker
        let imageLoadingManagerWorker: ImageLoadingWorker
        let realmServiceWorker: RealmService
    }

    func assembleDependencies() async -> DependenciesContainer {
        await .init(
            crashAnalyticReporter: CrashAnalytics(),
            firebaseRemoteConfigWorker: FirebaseRemoteConfigService(),
            imageLoadingManagerWorker: ImageManagerService(),
            // swiftlint:disable force_try
            realmServiceWorker: try! ConcreteRealmActor())
    }
}
