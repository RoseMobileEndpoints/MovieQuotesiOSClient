//
//  RHDetailViewController.m
//  MovieQuotes
//
//  Created by David Fisher on 7/8/14.
//  Copyright (c) 2014 Rose-Hulman. All rights reserved.
//

#import "RHDetailViewController.h"

#import "GTLMoviequotes.h"


@implementation RHDetailViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _updateView];
}

- (IBAction) pressedEditButton:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Edit quote"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Update quote", nil];

    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField* quoteTextField = [alert textFieldAtIndex:kQuoteTextFieldIndex];
    quoteTextField.placeholder = @"Quote";
    quoteTextField.text = self.movieQuote.quote;

    UITextField* movieTitleTextField = [alert textFieldAtIndex:kMovieTitleTextFieldIndex];
    movieTitleTextField.placeholder = @"Movie title";
    movieTitleTextField.secureTextEntry = NO;
    movieTitleTextField.text = self.movieQuote.movie;

    [alert show];
}

- (void) _updateView {
    self.movieTitleLabel.text = self.movieQuote.movie;
    self.quoteLabel.text = self.movieQuote.quote;
}

#pragma mark - UIAlertViewDelegate


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"Do nothing.  User hit cancel.");
        return;
    }
    NSString* movieTitle = [[alertView textFieldAtIndex:kMovieTitleTextFieldIndex] text];
    NSString* quote = [[alertView textFieldAtIndex:kQuoteTextFieldIndex] text];
    self.movieQuote.movie = movieTitle;
    self.movieQuote.quote = quote;
    [self _updateView];

    // TODO: Update the MovieQuote with Endpoints
}



@end
