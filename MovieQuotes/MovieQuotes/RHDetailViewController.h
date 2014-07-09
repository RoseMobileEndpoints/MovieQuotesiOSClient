//
//  RHDetailViewController.h
//  MovieQuotes
//
//  Created by David Fisher on 7/8/14.
//  Copyright (c) 2014 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTLMoviequotesMovieQuote;

#define kQuoteTextFieldIndex              0
#define kMovieTitleTextFieldIndex         1


@interface RHDetailViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) GTLMoviequotesMovieQuote* movieQuote;
@property (weak, nonatomic) IBOutlet UILabel* quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel* movieTitleLabel;

- (IBAction) pressedEditButton:(id)sender;


@end
