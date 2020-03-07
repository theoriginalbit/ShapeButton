# ShapeButton

A very simple library that provides a `UIButton` implementation that allows you to create a button that looks like the [Apple iOS Sketch library](https://developer.apple.com/design/resources/)'s 'Shape (Custom)' button.

The 'Shape (Custom)' button looks like:

![](.github/SketchExample.png)

The API is the same as with setting anything else that is state aware. The below code will produce a button like the image above.

```swift
import ShapeButton

// …
let myButton = ShapeButton(continuousCornerRadius: ShapeButton.cornerRadiusUseStandard)
myButton.setBackgroundColor(.systemBlue, for: .normal)
myButton.setTitleColor(.white, for: .normal)

// Stateful colors
myButton.setBackgroundColor(.systemGray, for: .disabled)
myButton.setTitleColor(.systemGray4, for: .disabled)
```

**NOTE:** Internally `setBackgroundColor` will generate a `UIImage` and call through to `setBackgroundImage(_:for:)` overriding any previous background image that may have been set.

## Installation

Swift Package Manager
