// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class ReadingListDataSource: NSObject
{
    @IBOutlet var store: ReadingListStore!
    lazy var readingList = store.fetchedReadingList
    
    func book(at indexPath: IndexPath) -> Book {
        return readingList.books[indexPath.row]
    }
    
    func insert(book: Book, at indexPath: IndexPath) {
        readingList.books.insert(book, at: indexPath.row)
    }
    
    func remove(at indexPath: IndexPath) {
        readingList.books.remove(at: indexPath.row)
    }
    
    func save() {
        store.save(readingList: readingList)
    }
}

private let unknown = "Unknown"
//private let cellIdentifier = "Book Summary"

private struct CellIdentifier {
    static let even = "Even"
    static let odd = "Odd"
}

// MARK: - UITableViewDataSource methods
extension ReadingListDataSource: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let strongBook = book(at: sourceIndexPath)
        remove(at: sourceIndexPath)
        insert(book: strongBook, at: destinationIndexPath)
        save()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        remove(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        save()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingList.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row % 2 == 0 ? CellIdentifier.even : CellIdentifier.odd
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            fatalError("Set the cell's identifier in the storyboard")
        }
        populate(cell: cell, at: indexPath)
        return cell
    }
    
    func populate(cell: UITableViewCell, at indexPath: IndexPath) {
        let book = self.book(at: indexPath)
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = "\(book.year ?? unknown)  \(book.author?.fullName ?? unknown)"
    }
}
