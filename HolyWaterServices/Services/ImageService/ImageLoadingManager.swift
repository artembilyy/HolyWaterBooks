//
//  ImageLoadingManager.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

public protocol ImageLoadingWorker {
    func getImage(from source: String) async throws -> UIImage
}

public protocol ImageLoadingWorkerContrainer {
    var imageLoadingManagerWorker: ImageLoadingWorker { get }
}

public final class ImageManagerService: ImageLoadingWorker {

    private var cache: ImageCacheManager
    // MARK: - Init
    public init() {
        self.cache = ImageCacheManager.shared
    }

    public func getImage(from source: String) async throws -> UIImage {
        guard let url = URL(string: source) else {
            throw NetworkError.invalidURL
        }

        let request = URLRequest(url: url)

        if let cachedImage = cache[source] {
            return cachedImage
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let image = UIImage(data: data) else {
                throw NetworkError.noImage
            }
            setImage(image, forKey: source)
            return image
        } catch {
            throw error
        }
    }

    private func setImage(
        _ image: UIImage,
        forKey key: String,
        compressionQuality: CGFloat = 0.5) {
        guard let compressedImageData = image.jpegData(compressionQuality: compressionQuality) else {
            return
        }
        cache[key] = UIImage(data: compressedImageData)
    }
}
