//
//  UIApplication+StatusBarHeight.swift
//  HolyWaterUI
//
//  Created by Артем Билый on 22.11.2023.
//

extension UIApplication {
    public var statusBarHeight: CGFloat {
        guard
            let scene = self.connectedScenes.first as? UIWindowScene,
            let height = scene.statusBarManager?.statusBarFrame.height
        else {
            return 0
        }
        return height
    }
}
