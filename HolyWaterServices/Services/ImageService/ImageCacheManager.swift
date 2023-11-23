//
//  ImageCacheManager.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

final class ImageCacheManager {

    static let shared = ImageCacheManager()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}
    // MARK: - Methods
    subscript(key: String) -> UIImage? {
        get {
            return cache.object(forKey: key as NSString)
        }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: key as NSString)
            } else {
                cache.removeObject(forKey: key as NSString)
            }
        }
    }

    func clearCache() {
        cache.removeAllObjects()
    }
}
