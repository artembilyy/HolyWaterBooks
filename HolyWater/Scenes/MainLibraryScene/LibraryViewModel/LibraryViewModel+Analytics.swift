//
//  LibraryViewModel+Analytics.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

extension LibraryViewModel {
    func sendCrashReport(event: CrashAnalytics.CrashEvent, source: String?) {
        dependencies
            .crashAnalyticReporter
            .sendCrashReport(
                crash: event, from: source)
    }
}
