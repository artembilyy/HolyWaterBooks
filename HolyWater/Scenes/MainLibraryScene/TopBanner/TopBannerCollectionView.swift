//
//  TopBannerCollectionView.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterServices
import HolyWaterUI
import RxSwift

final class TopBannerCollectionView: UICollectionViewCell, IdentifiableCell {

    lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: createCompositionalLayout())

    var viewModel: TopBannerCellViewModel?

    var pageControl: UIPageControl!
    var currentAutoScrollIndex = 1

    private var autoScrollTimer: Timer!

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
        collectionView.frame = bounds

        collectionView.register(cellType: TopBannerCell.self)

        collectionView.dataSource = self

        addSubview(collectionView)
        addPageControl()

        bindings()
        viewModel?.reloadData()
    }

    private func bindings() {
        viewModel?
            .outReloadData
            .drive(onNext: { [unowned self] _ in
                collectionView.reloadData()
                let indexPath = IndexPath(item: currentAutoScrollIndex, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
                configAutoScroll()
            })
            .disposed(by: disposeBag)
    }

    private func addPageControl() {
        guard let viewModel else { return }
        let pageControlerFrame = CGRect(
            x: frame.origin.x,
            y: collectionView.frame.origin.y + frame.height - 30,
            width: frame.size.width,
            height: 30)
        pageControl = UIPageControl(frame: pageControlerFrame)
        pageControl.numberOfPages = viewModel.topBooks.count - 2
        pageControl.currentPageIndicatorTintColor = ThemeColor.raspberryPink.asUIColor()
        pageControl.pageIndicatorTintColor = ThemeColor.lightGray.asUIColor()
        pageControl.isUserInteractionEnabled = false
        pageControl.allowsContinuousInteraction = false
        addSubview(pageControl)
    }
}

extension TopBannerCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.topBooks.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TopBannerCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.viewModel = viewModel
        cell.delegate = self
        cell.configure(indexPathItem: indexPath.item)
        return cell
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

extension TopBannerCollectionView {

    func configAutoScroll() {
        guard let viewModel else { return }
        resetAutoScrollTimer()
        if viewModel.topBooks.isEmpty.not {
            setupAutoScrollTimer()
        }
    }

    private func resetAutoScrollTimer() {
        if autoScrollTimer.isNil.not {
            autoScrollTimer.invalidate()
            autoScrollTimer = nil
        }
    }

    private func setupAutoScrollTimer() {
        autoScrollTimer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(autoScrollAction),
            userInfo: nil, repeats: true)
        RunLoop.main.add(autoScrollTimer, forMode: .common)
    }

    @objc
    private func autoScrollAction() {
        guard let viewModel else { return }
        currentAutoScrollIndex += 1
        if currentAutoScrollIndex >= viewModel.topBooks.count {
            currentAutoScrollIndex = currentAutoScrollIndex % viewModel.topBooks.count
        }
        let indexPath = IndexPath(item: currentAutoScrollIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
