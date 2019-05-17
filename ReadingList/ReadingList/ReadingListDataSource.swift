// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class ReadingListDataSource: NSObject
{
    @IBOutlet private var store: ReadingListStore!
    lazy private(set) var readingList = store.fetchedReadingList
    
    func book(at indexPath: IndexPath) -> Book {
        return readingList.book(at: indexPath)
    }
    
    func insert(book: Book, at indexPath: IndexPath) {
        readingList.insert(book: book, at: indexPath)
    }
    
    func remove(at indexPath: IndexPath) {
        readingList.removeBook(at: indexPath)
    }
    
    func save() {
        store.save(readingList: readingList)
    }
}

// MARK: - UITableViewDataSource methods
extension ReadingListDataSource: UITableViewDataSource
{
    private struct CellIdentifier {
        static let even = "Even"
        static let odd = "Odd"
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        readingList.moveBook(at: sourceIndexPath, to: destinationIndexPath)
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
        configure(cell: cell, at: indexPath)
        populate(cell: cell, at: indexPath)
        return cell
    }
}

private let unknown = "Unknown"

extension ReadingListDataSource
{
    func configure(cell: UITableViewCell, at indexPath: IndexPath) { }
    
    func populate(cell: UITableViewCell, at indexPath: IndexPath) {
        let book = self.book(at: indexPath)
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = "\(book.year ?? unknown)  \(book.author?.fullName ?? unknown)"
    }
}
