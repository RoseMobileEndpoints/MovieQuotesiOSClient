//
//  MovieQuoteDetailViewController.swift
//  MovieQuotesCoreData
//
//  Created by David Fisher on 1/23/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    var movieQuote : MovieQuote?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "showEditQuoteDialog")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    func showEditQuoteDialog() {
        let alertController = UIAlertController(title: "Edit movie quote", message: "", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Quote"
            textField.text = self.movieQuote?.quote
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Movie title"
            textField.text = self.movieQuote?.movie
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            (_) -> Void in
            println("Pressed Cancel")
        }
        let createQuoteAction = UIAlertAction(title: "Edit Quote", style: UIAlertActionStyle.Default) {
            (_) -> Void in
            let quoteTextField = alertController.textFields![0] as UITextField
            let movieTextField = alertController.textFields![1] as UITextField
            self.movieQuote?.quote = quoteTextField.text
            self.movieQuote?.movie = movieTextField.text
            self.updateView()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }

}










