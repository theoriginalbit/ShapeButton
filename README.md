# ShapeButton

A very simple library that provides a `UIButton` implementation that allows you to create a button that looks like the [Apple iOS Sketch library](https://developer.apple.com/design/resources/)'s 'Shape (Custom)' button.

The 'Shape (Custom)' button looks like:

![](.github/SketchExample.png)

The API is the same as with setting anything else that is state aware, simply call:

```swift
import ShapeButton

// …
let myButton = ShapeButton()
myButton.setBackgroundColor(.orange, for: .normal)
myButton.setBackgroundColor(.red, for: .pressed)
```

*NOTE:* Internally `setBackgroundColor` will generate a `UIImage` and call through to `setBackgroundImage(_:for:)` overriding any previous background image that may have been set.

## Installation

Swift Package Manager
