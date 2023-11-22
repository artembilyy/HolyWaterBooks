//
//  ProgressBarView.swift
//  HolyWater
//
//  Created by Артем Билый on 20.11.2023.
//

public final class ProgressBarView: UIView {

    private let progressColor: CGColor = ThemeColor.white.asCGColor()

    public var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayers() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.addSublayer(progressLayer)
        layer.backgroundColor = UIColor.gray.cgColor
    }

    public override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(
            roundedRect: rect,
            cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask

        let progressRect = CGRect(
            origin: .zero,
            size: CGSize(
                width: rect.width * progress,
                height: rect.height))

        progressLayer.frame = progressRect
        progressLayer.backgroundColor = progressColor
    }
}
