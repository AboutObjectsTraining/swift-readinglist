//
// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit

let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.title]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        configureAppearance()
    }
    
    func configureAppearance() {
        window?.tintColor = UIColor.tint
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = titleAttributes
        
        UITableView.appearance().backgroundColor = .alternateCell
        // UITableViewCell.appearance().backgroundColor = .cell
        UITextField.appearance().backgroundColor = .cell
        
        // Changing appearance based on types
        
        UITableView.appearance(whenContainedInInstancesOf: [AddBookController.self]).backgroundColor = .cool
        UITextField.appearance(whenContainedInInstancesOf: [AddBookController.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [AddBookController.self]).tintColor = .cool

        // Changing appearance based on size classes
        
        UITableView.appearance(for: UITraitCollection(verticalSizeClass: .compact)).backgroundColor = .alternateBackground
        UITableView.appearance(for: UITraitCollection(verticalSizeClass: .regular)).backgroundColor = .alternateCell
    }
}

// MARK: UIResponder methods
extension AppDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("In \(#function)")
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
