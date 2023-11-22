//
//  LibraryViewModel+Dependencies.swift
//  HolyWater
//
//  Created by Артем Билый on 21.11.2023.
//

import HolyWaterServices

extension LibraryViewModel {

    typealias Dependencies =
        CrashAnalyticReporterContainer &
        FirebaseRemoteConfigWorkerContainer
}
