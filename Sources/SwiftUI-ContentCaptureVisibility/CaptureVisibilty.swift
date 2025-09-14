import Foundation

/// A value that represents the visibility of a view when a screen capture occurs.
///
/// Use this enumeration to control whether a view appears normally, is hidden from
/// screen captures, or appears only in screen captures.
///
/// - normal: The view appears normally on screen and in screenshots.
/// - hiddenOnCapture: The view appears on screen but is hidden from screenshots.
/// - visibleOnlyOnCapture: The view is hidden on screen but visible in screenshots.
public enum CaptureVisibility: CaseIterable, Equatable, Hashable {
    case normal
    case hiddenOnCapture
    case visibleOnlyOnCapture
}
