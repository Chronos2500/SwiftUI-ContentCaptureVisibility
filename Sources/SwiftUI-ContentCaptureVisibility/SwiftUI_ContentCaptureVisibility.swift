import SwiftUI

public extension View {
    /// Applies the given `CaptureVisibility` to the view.
    ///
    /// - Parameter visibility: The screen-capture visibility to apply.
    /// - Returns: A view that respects the specified screen-capture visibility.
    func contentCaptureVisibility(_ visibility: CaptureVisibility) -> some View {
        modifier(ContentCaptureVisibilityModifier(captureVisibility: visibility))
    }
}

internal struct ContentCaptureVisibilityModifier: ViewModifier {
    let captureVisibility: CaptureVisibility
    func body(content: Content) -> some View {
        content
            .mask {
                CaptureMaskView()
                    .modifier { view in
                        switch captureVisibility {
                        case .normal:
                            view.overlay(.black)
                        case .hiddenOnCapture:
                            view
                        case .visibleOnlyOnCapture:
                            view.background(.white).compositingGroup().luminanceToAlpha()
                        }
                    }
            }
    }
}

internal struct CaptureMaskView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        let canvasView = textField.subviews.first {
            type(of: $0).description().contains("CanvasView")
        }
        canvasView?.backgroundColor = .black
        canvasView?.isUserInteractionEnabled = false
        if canvasView == nil {
            assertionFailure("CaptureMaskView: CanvasView not found")
        }
        return canvasView ?? UIView()
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}
