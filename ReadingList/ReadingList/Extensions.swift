// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.
//
import UIKit
import ReadingListModel

extension UIColor {
    struct Names {
        static let tint = "Tint Color"
        static let title = "Title Color"
        static let cell = "Cell Color"
        static let alternateCell = "Alternate Cell Color"
    }
    static let tint = UIColor(named: Names.tint) ?? UIColor.black
    static let title = UIColor(named: Names.title) ?? UIColor.black
    static let cell = UIColor(named: Names.cell) ?? UIColor.white
    static let alternateCell = UIColor(named: Names.alternateCell) ?? UIColor.white
}

extension UIStoryboardSegue
{
    struct Identifiers {
        static let view = "View"
        static let add = "Add"
        static let done = "Done"
    }
    
    var realDestination: UIViewController? {
        guard let navController = destination as? UINavigationController else {
            return destination
        }
        return navController.children.first
    }
}

extension Dictionary where Key == String, Value == Any?
{
    var flattened: JsonDictionary {
        return mapValues { value -> Any in
            switch value {
            case let (dict?) as [String: Any?]?: return dict.flattened
            case let (string?) as String?: return string
            default: return value ?? ""
            }
        }
    }
}

extension IndexPath
{
    static let zero = IndexPath(row: 0, section: 0)
}

extension String
{
    static var blank: String { return "" }
}
