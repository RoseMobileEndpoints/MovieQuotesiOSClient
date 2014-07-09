//
//  RHDetailViewController.m
//  MovieQuotes
//
//  Created by David Fisher on 7/8/14.
//  Copyright (c) 2014 Rose-Hulman. All rights reserved.
//

#import "RHDetailViewController.h"

#import "GTLMoviequotes.h"


@interface RHDetailViewController ()
- (void)configureView;
@end

@implementation RHDetailViewController

#pragma mark - Managing the detail item

- (void)setQuote:(GTLMoviequotesMovieQuote*) quote {
    if (_quote != quote) {
        _quote = quote;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.movieTitleLabel.text = self.quote.movie;
    self.quoteLabel.text = self.quote.quote;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}


- (IBAction)pressedEditButton:(id)sender {
}

@end
