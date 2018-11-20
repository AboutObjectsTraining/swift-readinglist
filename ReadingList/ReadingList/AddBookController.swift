// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class AddBookController: UITableViewController
{
    var done: ((Book) -> Void)?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    // MARK: - Obtaining a dictionary of UI values
    var author: Author {
        return Author(dictionary: [Author.Keys.firstName: firstNameField.text ?? String.blank,
                                   Author.Keys.lastName: lastNameField.text ?? String.blank])
    }
    var book: Book {
        return Book(dictionary: [Book.Keys.title: titleField.text ?? String.blank,
                                 Book.Keys.year: yearField.text ?? String.blank,
                                 Book.Keys.author: author])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIStoryboardSegue.Identifiers.done {
            done?(flattenedBook)
        }
    }
}

extension AddBookController
{
    // MARK: - Alternate approach
    var flattenedAuthor: Author {
        let authorDict: [String: Any?] = [Author.Keys.firstName: firstNameField.text,
                                          Author.Keys.lastName: lastNameField.text]
        return Author(dictionary: authorDict.flattened)
    }
    var flattenedBook: Book {
        let bookDict: [String: Any?] = [Book.Keys.title: titleField.text,
                                        Book.Keys.year: yearField.text,
                                        Book.Keys.author: author]
        return Book(dictionary: bookDict.flattened)
    }
}
