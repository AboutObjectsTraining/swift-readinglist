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
        window?.tintColor = .tint
        configureAppearance()
    }
    
    func configureAppearance() {
        UITextField.appearance().backgroundColor = .cell
        
        let navBarProxy = UINavigationBar.appearance()
        navBarProxy.titleTextAttributes = titleAttributes
        navBarProxy.largeTitleTextAttributes = titleAttributes
        
        // Changing appearance based on types
        
        let addBookTextFieldProxy = UITextField.appearance(whenContainedInInstancesOf: [AddBookController.self])
        addBookTextFieldProxy.backgroundColor = .add
        addBookTextFieldProxy.tintColor = .purple

        // Changing appearance based on size classes
        
        let compactHeightTableViewProxy = UITableView.appearance(for: UITraitCollection(verticalSizeClass: .compact))
        let regularHeightViewAndEditTableViewProxy =  UITableView.appearance(for: UITraitCollection(verticalSizeClass: .regular))
        
        compactHeightTableViewProxy.backgroundColor = .alternateBackground
        regularHeightViewAndEditTableViewProxy.backgroundColor = .alternateCell
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
