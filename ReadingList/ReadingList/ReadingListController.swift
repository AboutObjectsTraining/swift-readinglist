import UIKit

class ReadingListController: UITableViewController
{
    @IBOutlet var dataSource: ReadingListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "View":
            guard
                let indexPath = tableView.indexPathForSelectedRow,
                let controller = segue.realDestination as? ViewBookController else { return }
            controller.book = dataSource.book(at: indexPath)
        case "Add":
            guard let controller = segue.realDestination as? AddBookController else { return }
            controller.done = { [weak self] book in self?.insert(book: book, at: IndexPath.zero) }
        default: break
        }
    }
    
    func insert(book: Book, at indexPath: IndexPath) {
        dataSource.insert(book: book, at: indexPath)
        dataSource.save()
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// TODO: Move to Extensions.swift
extension IndexPath
{
    static var zero: IndexPath { return IndexPath(row: 0, section: 0) }
}

// MARK: - Unwind segues
extension ReadingListController
{
    @IBAction func doneEditing(segue: UIStoryboardSegue) {
        tableView.reloadData()
        dataSource.save()
    }
    @IBAction func doneAdding(segue: UIStoryboardSegue) {
        // TODO: save, etc.
    }
    @IBAction func cancel(segue: UIStoryboardSegue) { }
}







extension ReadingListController
{
    func example_tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if let cachedCell = tableView.dequeueReusableCell(withIdentifier: "Foo Bar") {
            cell = cachedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Foo Bar")
        }
        
        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        
        return cell
    }
}
