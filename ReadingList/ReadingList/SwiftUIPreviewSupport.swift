// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

// MARK: SwiftUI Preview Example

#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI

// MARK: - UIView Preview

private let austen = "Austen"
private let tolstoy = "Tolstoy"

// MARK: Generic View Wrapper
@available(iOS 13.0, *)
private struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    init(_ builder: @escaping () -> View) { view = builder() }
    func makeUIView(context: Context) -> UIView { return view }
    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

// MARK: UIImageView Preview Provider
@available(iOS 13.0, *)
struct ImageViewPreviewProvider: PreviewProvider {
  static var previews: some View {
    Group {
        UIViewPreview { UIImageView(named: austen, cornerRadius: 190) }.previewDisplayName(austen)
        UIViewPreview { UIImageView(named: tolstoy, cornerRadius: 15) }.previewDisplayName(tolstoy)
        ForEach(ColorScheme.allCases, id: \.self) {
            UIViewPreview { UIImageView(named: "Shakespeare", cornerRadius: 25) }
                .environment(\.colorScheme, $0)
                .previewDisplayName("\($0) Appearance".capitalized)
        }
    }.previewLayout(.sizeThatFits).padding(48)
  }
}

// MARK: UIImageView Conveniences
private extension UIImageView {
    convenience init(named name: String, cornerRadius: CGFloat) {
        self.init(image: UIImage(named: name))
        self.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}

// MARK: - UIViewController Preview

private let deviceNames = ["iPhone SE", "iPhone 11 Pro"]

// MARK: Generic View Controller Wrapper
@available(iOS 13.0, *)
private struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    init(_ builder: @escaping () -> ViewController) { viewController = builder() }
    func makeUIViewController(context: Context) -> UIViewController { return viewController }
    func updateUIViewController(_ viewController: UIViewController,
                                context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) { }
}

// MARK: View Controller Preview Provider
@available(iOS 13.0, *)
struct ViewControllerPreviewProvider: PreviewProvider {
    static var previews: some View {
        ForEach(deviceNames, id: \.self) { deviceName in
            UIViewControllerPreview {
                UIStoryboard(name: "Main", bundle:nil).instantiateInitialViewController { UINavigationController(coder: $0) }!
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

#endif
