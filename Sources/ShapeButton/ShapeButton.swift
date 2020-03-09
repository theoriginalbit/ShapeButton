import UIKit

/// An extension of `UIButton` that provides functionality to easily change the background color based on state in a similar fashion to `setTitleColor(_:for:)`.
open class ShapeButton: UIButton {
    public static let cornerRadiusUseStandard: CGFloat = 8

    private var backwardCompatLayerMask: CAShapeLayer?

    open override var bounds: CGRect {
        didSet {
            updateCornerRadius()
        }
    }

    open override var backgroundColor: UIColor? {
        didSet {
            setBackgroundImage(backgroundColor?.image(), for: .normal)
        }
    }

    /// Initializes and returns a newly allocated button with the specified corner radius using `layer.cornerRadius`.
    ///
    /// - Parameters:
    ///   - frame:          The frame of the button. Defaults to `.zero`
    ///   - cornerRadius:   When positive, the background of the layer will be drawn with rounded corners.
    public init(frame: CGRect = .zero, cornerRadius: CGFloat) {
        super.init(frame: frame)

        layer.cornerRadius = cornerRadius
        setBackgroundColor(backgroundColor, for: .normal)
    }

    /// Initializes and returns a newly allocated button with the specified corner radius using `layer.cornerRadius`. The corners will be continuous using `layer.cornerCurve` and pre-iOS 13 are implemented through a `CAShapeLayer` masking the button that resizes on `bound`s update.
    ///
    /// - Parameters:
    ///   - frame:          The frame of the button. Defaults to `.zero`
    ///   - cornerRadius:   When positive, the background of the layer will be drawn with rounded corners.
    public init(frame: CGRect = .zero, continuousCornerRadius cornerRadius: CGFloat) {
        super.init(frame: frame)

        layer.cornerRadius = cornerRadius
        if #available(iOS 13, *) {
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        } else {
            // Create a masking shape that will do continuous corners pre-iOS 13
            backwardCompatLayerMask = CAShapeLayer()
            layer.mask = backwardCompatLayerMask
            updateCornerRadius()
        }
        setBackgroundColor(backgroundColor, for: .normal)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    /// Calls through to `setBackgroundImage` with a generates a 1x1 `UIImage` of the provided colour.
    ///
    /// - Parameters:
    ///   - color:  The background color for the button.
    ///   - state:  The state the color should display under. follows the same rules as `setBackgroundImage(_:for:)`.
    @objc open dynamic func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        setBackgroundImage(color?.image(), for: state)
    }

    /// Updates the `UIBezierPath` that provides the continuous corner curve on pre-iOS 13 builds.
    private func updateCornerRadius() {
        guard let backwardCompatLayerMask = backwardCompatLayerMask else { return }
        backwardCompatLayerMask.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}

// MARK: - Background Image Helper

private extension UIColor {
    func image(_ size: CGSize = .init(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
