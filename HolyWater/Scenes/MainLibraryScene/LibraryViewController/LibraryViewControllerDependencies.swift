//
//  LibraryViewControllerDependencies.swift
//  HolyWater
//
//  Created by Артем Билый on 24.11.2023.
//

import HolyWaterServices

extension LibraryViewController {

    typealias Dependencies =
        CrashAnalyticReporterContainer &
        FirebaseRemoteConfigWorkerContainer &
        ImageLoadingWorkerContrainer
}
