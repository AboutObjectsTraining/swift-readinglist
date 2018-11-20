// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class ReadingListController: UITableViewController
{
    @IBOutlet private var dataSource: ReadingListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case UIStoryboardSegue.Identifiers.view:
            guard let controller = segue.realDestination as? ViewBookController else { return }
            controller.book = dataSource.book(at: tableView.indexPathForSelectedRow ?? IndexPath.zero)
        case UIStoryboardSegue.Identifiers.add:
            guard let controller = segue.realDestination as? AddBookController else { return }
            controller.done = { [weak self] book in self?.insert(book: book, at: IndexPath.zero) }
        default: break
        }
    }
    
    private func insert(book: Book, at indexPath: IndexPath) {
        dataSource.insert(book: book, at: indexPath)
        dataSource.save()
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - Unwind segues
extension ReadingListController
{
    @IBAction func doneEditing(segue: UIStoryboardSegue) {
        tableView.reloadData()
        dataSource.save()
    }
    @IBAction func doneAdding(segue: UIStoryboardSegue) { }
    @IBAction func cancel(segue: UIStoryboardSegue) { }
}

