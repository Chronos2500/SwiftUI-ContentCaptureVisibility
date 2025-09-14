import Testing
import UIKit

@Test("UITextField secure entry has CanvasView with _disableUpdateMask = 18")
@MainActor
func secureTextFieldCanvasViewTest() {
    let textField = UITextField()
    textField.isSecureTextEntry = true

    let canvasView = textField.subviews.first { type(of: $0).description().contains("CanvasView") }

    #expect(canvasView != nil, "UITextField with secure entry should contain CanvasView")

    guard let canvasView = canvasView else { return }

    let disableUpdateMaskValue = canvasView.layer.value(forKey: "disableUpdateMask") as? Int
    #expect(disableUpdateMaskValue == 18, "disableUpdateMask should be 18")
}
