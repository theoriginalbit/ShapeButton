import os.log
import UIKit

/// An extension of `UIButton` that provides functionality to easily change the background color based on state in a similar fashion to
/// `setTitleColor(_:for:)`. It also provides corner radius and curve (iOS 13+) setting via the initializers.
public class ShapeButton: UIButton {
    private var backwardCompatLayerMask: CAShapeLayer?

    public override var bounds: CGRect {
        didSet {
            updateCornerRadius()
        }
    }

    /// Initializes and returns a newly allocated button with the specified corner radius using `layer.cornerRadius`.
    ///
    /// - Parameters:
    ///   - frame:          The frame of the button. Defaults to `.zero`
    ///   - cornerRadius:   When positive, the background of the layer will be drawn with rounded corners. Defaults to `8`.
    public init(frame: CGRect = .zero, cornerRadius: CGFloat = 8) {
        super.init(frame: frame)

        if #available(iOS 13, *) {
            os_log(.error, log: .default, "Prefer usage of init(frame:cornerRadius:cornerCurve:) on iOS 13")
        }

        layer.cornerRadius = cornerRadius
        setBackgroundColor(backgroundColor, for: .normal)
    }

    /// Initializes and returns a newly allocated button with the specified corner radius using `layer.cornerRadius`. The corners
    /// will be continuous and implemented through a `CAShapeLayer` masking the button that resizes on `bound`s update.
    ///
    /// - Parameters:
    ///   - frame:          The frame of the button. Defaults to `.zero`
    ///   - cornerRadius:   When positive, the background of the layer will be drawn with rounded corners. Defaults to `8`.
    public convenience init(frame: CGRect = .zero, continuousCornerRadius cornerRadius: CGFloat = 8) {
        self.init(frame: frame, cornerRadius: cornerRadius)

        // A continuous corner was requested, create a masking shape layer that will do this pre-iOS 13
        backwardCompatLayerMask = CAShapeLayer()
        layer.mask = backwardCompatLayerMask
        updateCornerRadius()
    }

    /// Initializes and returns a newly allocated button with the specified corner radius using `layer.cornerRadius` and
    /// corner curve using `layer.cornerCurve`.
    ///
    /// - Parameters:
    ///   - frame:          The frame of the button. Defaults to `.zero`
    ///   - cornerRadius:   When positive, the background of the layer will be drawn with rounded corners. Defaults to `8`.
    ///   - cornerCurve:    The curve used for rendering the rounded corners of the layer. Defaults to `.continuous`.
    @available(iOS 13.0, *)
    public init(frame: CGRect = .zero, cornerRadius: CGFloat = 8, cornerCurve: CALayerCornerCurve = .continuous) {
        super.init(frame: frame)

        layer.cornerRadius = cornerRadius
        layer.cornerCurve = cornerCurve
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
    @objc public dynamic func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
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
