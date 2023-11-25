//
//  TopBooksCollectionTableViewCell.swift
//  HolyWater
//
//  Created by Артем Билый on 23.11.2023.
//

import HolyWaterUI

protocol InfiniteAutoScrollViewDelegate: AnyObject {
    func didTapItem()
}

extension TopBooksCollectionTableViewCell {

    func configAutoScroll() {
        resetAutoScrollTimer()
        if viewModel.topBooks.count > 1 {
            setupAutoScrollTimer()
        }
    }

    func resetAutoScrollTimer() {
        if autoScrollTimer != nil {
            autoScrollTimer.invalidate()
            autoScrollTimer = nil
        }
    }

    func setupAutoScrollTimer() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScrollAction(timer:)), userInfo: nil, repeats: true)
        RunLoop.main.add(autoScrollTimer, forMode: RunLoop.Mode.common)
    }

    @objc func autoScrollAction(timer: Timer) {
//        if self.window != nil {
        currentAutoScrollIndex += 1
        if currentAutoScrollIndex >= viewModel.topBooks.count {
            currentAutoScrollIndex = currentAutoScrollIndex % viewModel.topBooks.count
            print(currentAutoScrollIndex)
        }
        collectionView.scrollToItem(at: IndexPath(item: currentAutoScrollIndex, section: 0), at: .left, animated: true)
//        }
    }

    func addPageControl() {
        pageControl = UIPageControl(frame: CGRect(
            x: frame.width / 2,
            y: frame.height / 2,
            width: frame.size.width / 2,
            height: 40.0))
        pageControl.numberOfPages = viewModel.topBooks.count - 2
        pageControl.currentPageIndicatorTintColor = .purple
        pageControl.pageIndicatorTintColor = .black
        pageControl.isUserInteractionEnabled = false
        pageControl.allowsContinuousInteraction = false
//        pageControl.addTarget(self, action: #selector(changePage(_:)), for: .valueChanged)
        addSubview(pageControl)
    }

//    @objc func changePage(_ sender: UIPageControl) {
//        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage + 1, section: 0), at: .left, animated: true)
//    }
}

final class TopBooksCollectionTableViewCell: UITableViewCell, IdentifiableCell, UICollectionViewDelegate {

    var pageControl: UIPageControl!
    var autoScrollTimer: Timer!
    var currentAutoScrollIndex = 1

    lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: createCompositionalLayout())

    weak var delegate: InfiniteAutoScrollViewDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    var viewModel: TopBannerCellViewModel!

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - UI Setup

extension TopBooksCollectionTableViewCell {

    private func setupUI() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true

        collectionView.register(
            TopBannerCell.self,
            forCellWithReuseIdentifier: TopBannerCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)
        self.addPageControl()

        collectionView.frame = bounds

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
            self.configAutoScroll()

            //            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
//            self.addPageControl()
//            self.configAutoScroll()
        }

    }
}

extension TopBooksCollectionTableViewCell: InfiniteAutoScrollViewCellDelegate {

    func invalidateTimer() {
        if autoScrollTimer != nil {
            autoScrollTimer?.invalidate()
            autoScrollTimer = nil
        }
    }
}

extension TopBooksCollectionTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.topBooks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCell.identifier, for: indexPath) as? TopBannerCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel
        cell.delegate = self
        cell.configure(indexPathItem: indexPath.item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapItem()
    }
}
