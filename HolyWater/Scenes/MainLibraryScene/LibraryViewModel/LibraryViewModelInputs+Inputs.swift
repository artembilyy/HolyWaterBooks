//
//  LibraryViewModelInputs+Inputs.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices

protocol LibraryViewModelInputs {
    func fetch()
    func selected(item: BookResponse.TopBannerSlideBook)
    func sendCrashReport(
        event: CrashAnalytics.CrashEvent,
        source: String?)
}
