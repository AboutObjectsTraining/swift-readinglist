//
// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this example's licensing information.
//
import UIKit
import ReadingListModel

class ViewBookController: UITableViewController
{
    var book: Book?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction private func cancel(segue: UIStoryboardSegue) { }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }

    private func refreshData() {
        titleLabel.text = book?.title
        yearLabel.text = book?.year
        firstNameLabel.text = book?.author?.firstName
        lastNameLabel.text = book?.author?.lastName
        imageView.image = UIImage(named: book?.author?.lastName ?? "Unknown")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.realDestination as? EditBookController  else { return }
        controller.book = book
    }
}
