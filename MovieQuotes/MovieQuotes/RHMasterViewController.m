//
//  RHMasterViewController.m
//  MovieQuotes
//
//  Created by David Fisher on 7/8/14.
//  Copyright (c) 2014 Rose-Hulman. All rights reserved.
//

#import "RHMasterViewController.h"

#import "RHDetailViewController.h"
#import "RHTemporaryMovieQuoteModelObject.h"

#define kMovieQuoteCellIdentifier         @"MovieQuoteCell"
#define kLoadingMovieQuotesCellIdentifier @"LoadingMovieQuotesCell"
#define kNoMovieQuotesCellIdentifier      @"NoMovieQuotesCell"
#define kPushDetailQuoteSegue             @"PushDetailQuoteSegue"
#define kQuoteTextFieldIndex              0
#define kMovieTitleTextFieldIndex         1


@interface RHMasterViewController ()
@property (nonatomic) BOOL initialQueryComplete;
@property (strong, nonatomic) NSMutableArray* quotes;
@end

@implementation RHMasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}


- (void) viewWillAppear:(BOOL)animated {

    // TODO: Query the backend
    self.initialQueryComplete = YES; // TODO: Delete this line.
    //self.initialQueryComplete = NO;
    //[self _queryForQuotes];
}


- (void)insertNewObject:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Create a new quote"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Create quote", nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField* quoteTextField = [alert textFieldAtIndex:kQuoteTextFieldIndex];
    quoteTextField.placeholder = @"Quote";
    UITextField* movieTitleTextField = [alert textFieldAtIndex:kMovieTitleTextFieldIndex];
    movieTitleTextField.placeholder = @"Movie title";
    [movieTitleTextField setSecureTextEntry:NO];
    [alert show];
}


- (NSMutableArray*) quotes {
    if (_quotes == nil) {
        _quotes = [[NSMutableArray alloc] init];

        // Add some code for initial testing.
//        RHTemporaryMovieQuoteModelObject* mq1 = [[RHTemporaryMovieQuoteModelObject alloc] init];
//        mq1.quote = @"Local quote 1";
//        mq1.movie = @"Local movie 1";
//        [_quotes addObject:mq1];
//
//
//        RHTemporaryMovieQuoteModelObject* mq2 = [[RHTemporaryMovieQuoteModelObject alloc] init];
//        mq2.quote = @"Local quote 2";
//        mq2.movie = @"Local movie 2";
//        [_quotes addObject:mq2];
//
//
//        RHTemporaryMovieQuoteModelObject* mq3 = [[RHTemporaryMovieQuoteModelObject alloc] init];
//        mq3.quote = @"Local quote 3";
//        mq3.movie = @"Local movie 3";
//        [_quotes addObject:mq3];

    }
    return _quotes;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.quotes.count == 0) ? 1 : self.quotes.count;
}

- (UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath {
    UITableViewCell *cell = nil;
    if (self.quotes.count == 0) {
        if (self.initialQueryComplete) {
            cell = [tableView dequeueReusableCellWithIdentifier:kNoMovieQuotesCellIdentifier forIndexPath:indexPath];
            cell.accessoryView = nil;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:kLoadingMovieQuotesCellIdentifier forIndexPath:indexPath];
            UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            cell.accessoryView = spinner;
            [spinner startAnimating];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kMovieQuoteCellIdentifier forIndexPath:indexPath];
        cell.accessoryView = nil;
        RHTemporaryMovieQuoteModelObject* currentQuote = self.quotes[indexPath.row];
        cell.textLabel.text = currentQuote.quote;
        cell.detailTextLabel.text = currentQuote.movie;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)tableView:(UITableView*) tableView canEditRowAtIndexPath:(NSIndexPath*) indexPath {
    // Return NO if you do not want the specified item to be editable.
    return (self.quotes.count == 0) ? NO : YES;
}


- (void) tableView:(UITableView*) tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath*) indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // TODO: Send a message to the backend to remove this quote.

        [self.quotes removeObjectAtIndex:indexPath.row];
        if (self.quotes.count == 0) {
            [tableView reloadData];
            [self setEditing:NO animated:YES];  // Nothing more to delete so end editing mode.
        } else {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kPushDetailQuoteSegue]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RHTemporaryMovieQuoteModelObject *movieQuote = self.quotes[indexPath.row];
        [[segue destinationViewController] setQuote:movieQuote];
    }
}

#pragma mark - UIAlertViewDelegate


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"Do nothing.  User hit cancel");
        return;
    }

    NSString* movieTitle = [[alertView textFieldAtIndex:kMovieTitleTextFieldIndex] text];
    NSString* quote = [[alertView textFieldAtIndex:kQuoteTextFieldIndex] text];


    RHTemporaryMovieQuoteModelObject* newQuote = [[RHTemporaryMovieQuoteModelObject alloc] init];
    newQuote.movie = movieTitle;
    newQuote.quote = quote;

    [self.quotes insertObject:newQuote atIndex:0];

    // Use the fancy insert animation with the deployed version.
    if (self.quotes.count == 1) {
        [self.tableView reloadData];
    } else {
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // Warning: This animation can cause an issue with localhost testing. If that happens just use reloadData always.
    }
}


@end