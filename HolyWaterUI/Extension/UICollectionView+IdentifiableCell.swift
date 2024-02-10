//
//  UICollectionView+IdentifiableCell.swift
//  HolyWaterUI
//
//  Created by Artem Bilyi on 09.02.2024.
//

public extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        ofType cellType: T.Type = T.self,
        customIdentifier: String? = nil) -> T where T: IdentifiableCell {

        let identifier = customIdentifier ?? cellType.identifier

        guard let cell = dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath) as? T else {

            register(
                cellType,
                forCellWithReuseIdentifier: identifier)

            return dequeueReusableCell(
                for: indexPath,
                ofType: cellType,
                customIdentifier: identifier)
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String,
        for indexPath: IndexPath,
        ofType viewType: T.Type = T.self,
        customIdentifier: String? = nil) -> T where T: IdentifiableCell {

        let identifier = customIdentifier ?? viewType.identifier

        guard let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: identifier,
            for: indexPath) as? T else {

            register(
                viewType,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: viewType.identifier)

            return dequeueReusableSupplementaryView(
                ofKind: elementKind,
                for: indexPath,
                ofType: viewType,
                customIdentifier: identifier)
        }

        return view
    }

    func register(cellType: (some UICollectionViewCell & IdentifiableCell).Type) {
        register(
            cellType,
            forCellWithReuseIdentifier: cellType.identifier)
    }

    func registerHeader(type: (some UICollectionReusableView & IdentifiableCell).Type) {
        register(
            type,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: type.identifier)
    }
}
