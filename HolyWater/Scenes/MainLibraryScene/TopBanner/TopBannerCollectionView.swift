//
//  TopBannerCollectionView.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import HolyWaterUI
import RxSwift

extension TopBannerCollectionView {

    func configAutoScroll() {
        guard let viewModel else { return }
        resetAutoScrollTimer()
        if viewModel.topBooks.isEmpty.not {
            setupAutoScrollTimer()
        }
    }

    func resetAutoScrollTimer() {
        if autoScrollTimer.isNil.not {
            autoScrollTimer.invalidate()
            autoScrollTimer = nil
        }
    }

    func setupAutoScrollTimer() {
        autoScrollTimer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(autoScrollAction),
            userInfo: nil, repeats: true)
        RunLoop.main.add(autoScrollTimer, forMode: RunLoop.Mode.common)
    }

    @objc private func autoScrollAction() {
        guard let viewModel else { return }
        currentAutoScrollIndex += 1
        if currentAutoScrollIndex >= viewModel.topBooks.count {
            currentAutoScrollIndex = currentAutoScrollIndex % viewModel.topBooks.count
        }
        let indexPath: IndexPath = .init(item: currentAutoScrollIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }

    func addPageControl() {
        guard let viewModel else { return }
        pageControl = UIPageControl(frame: CGRect(
            x: self.frame.origin.x,
            y: self.collectionView.frame.origin.y + self.frame.height - 30,
            width: self.frame.size.width,
            height: 30))
        pageControl.numberOfPages = viewModel.topBooks.count - 2
        pageControl.currentPageIndicatorTintColor = ThemeColor.raspberryPink.asUIColor()
        pageControl.pageIndicatorTintColor = ThemeColor.lightGray.asUIColor()
        pageControl.isUserInteractionEnabled = false
        pageControl.allowsContinuousInteraction = false
        addSubview(pageControl)
    }
}

final class TopBannerCollectionView: UICollectionViewCell, IdentifiableCell, UICollectionViewDelegate {

    var pageControl: UIPageControl!
    var autoScrollTimer: Timer!
    var currentAutoScrollIndex = 1

    lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: createCompositionalLayout())

    var viewModel: TopBannerCellViewModel?

    private let disposeBag = DisposeBag()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

// MARK: - UI Setup

extension TopBannerCollectionView {

    private func setupUI() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false

        collectionView.register(
            TopBannerCell.self,
            forCellWithReuseIdentifier: TopBannerCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)
        self.addPageControl()

        collectionView.frame = bounds

        bindings()
    }

    private func bindings() {
        viewModel?
            .outReloadData
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                self.collectionView.reloadData()
                let indexPath: IndexPath = .init(item: self.currentAutoScrollIndex, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
                self.configAutoScroll()
            })
            .disposed(by: disposeBag)
    }

}

extension TopBannerCollectionView: InfiniteAutoScrollViewCellDelegate {

    func invalidateTimer() {
        if autoScrollTimer.isNil.not {
            autoScrollTimer?.invalidate()
            autoScrollTimer = nil
        }
    }
}

extension TopBannerCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.topBooks.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCell.identifier, for: indexPath) as? TopBannerCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel
        cell.delegate = self
        cell.configure(indexPathItem: indexPath.item)
        return cell
    }
}
