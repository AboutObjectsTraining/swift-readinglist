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
        
        UITableView.appearance().backgroundColor = UIColor.alternateCell
        UITableViewCell.appearance().backgroundColor = UIColor.cell
        UITextField.appearance().backgroundColor = UIColor.cell
    }
}

