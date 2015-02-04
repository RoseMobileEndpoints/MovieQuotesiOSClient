//
//  MovieQuotesTableViewController.swift
//  MovieQuotesCoreData
//
//  Created by David Fisher on 1/23/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {

    let movieQuoteCellIdentifier = "MovieQuoteCell"
    let noMovieQuotesCellIdentifier = "NoMovieQuotesCell"
    let showDetailSegueIdentifier = "ShowDetailSegue"

    var movieQuotes = [MovieQuote]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showAddQuoteDialog")

        movieQuotes.append(MovieQuote(quote: "I'll be back", movie: "The Terminator"))
        movieQuotes.append(MovieQuote(quote: "Yo Adrian!", movie: "Rocky"))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func showAddQuoteDialog() {
        let alertController = UIAlertController(title: "Create a new movie quote", message: "", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Quote"
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Movie title"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            (_) -> Void in
            println("Pressed Cancel")
        }
        let createQuoteAction = UIAlertAction(title: "Create Quote", style: UIAlertActionStyle.Default) {
            (_) -> Void in
            let quoteTextField = alertController.textFields![0] as UITextField
            let movieTextField = alertController.textFields![1] as UITextField
            let movieQuote = MovieQuote(quote: quoteTextField.text, movie: movieTextField.text)
            self.movieQuotes.insert(movieQuote, atIndex: 0)
            if self.movieQuotes.count == 1 {
                self.tableView.reloadData()
            } else {
                let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(movieQuotes.count, 1)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if movieQuotes.count == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier(noMovieQuotesCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier(movieQuoteCellIdentifier, forIndexPath: indexPath) as UITableViewCell
            let movieQuote = movieQuotes[indexPath.row]
            cell.textLabel?.text = movieQuote.quote
            cell.detailTextLabel?.text = movieQuote.movie
        }
        return cell
    }

    override func setEditing(editing: Bool, animated: Bool) {
        if movieQuotes.count == 0 {
            super.setEditing(false, animated: false)
        } else {
            super.setEditing(editing, animated: animated)
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return movieQuotes.count > 0
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            movieQuotes.removeAtIndex(indexPath.row)
            if movieQuotes.count == 0 {
                tableView.reloadData()
                setEditing(false, animated: true)
            } else {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == showDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow() {
                let movieQuote = movieQuotes[indexPath.row]
                (segue.destinationViewController as MovieQuoteDetailViewController).movieQuote = movieQuote
            }

        }
    }

}











