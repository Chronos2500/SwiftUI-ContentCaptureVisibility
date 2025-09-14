import SwiftUI

struct ContentView: View {
    // \.isSceneCaptured is available in iOS 17.0+
    @Environment(\.isSceneCaptured) private var isSceneCaptured
    @State private var isAlertPresented = false
    var body: some View {
        NavigationStack {
            ScrollView {
                cardInfo
                    .contentCaptureVisibility(.hiddenOnCapture)
                    .background(cardBackground)
                    .overlay{
                        captureWarning
                            .contentCaptureVisibility(.visibleOnlyOnCapture)
                    }
                    .padding()
            }
            .navigationTitle("Credit Card")
            .onReceive(
                NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)
            ) { _ in
                isAlertPresented = true
            }
            .onChange(of: isSceneCaptured) {
                if isSceneCaptured {
                    isAlertPresented = true
                }
            }
            .alert(
                "Screenshot Detected",
                isPresented: $isAlertPresented,
                actions: {}
            ) {
                Text("A screenshot or screen recording was detected.")
            }
        }
    }

    var cardInfo: some View {
        VStack {
            Text(verbatim: "0000 0000 0000 0000")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.vertical, 50)

            Text("00/00")
            Text("Your Name")
        }
        .font(.system(size: 20, weight: .semibold, design: .monospaced))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding()
    }

    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.blue.gradient)
    }

    var captureWarning: some View {
        Image(systemName: "eye.slash.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.pink)
            .shadow(color: .white, radius: 20, x: 0, y: 0)
            .padding(50)
    }
}
