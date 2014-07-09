//
//  RHDetailViewController.h
//  MovieQuotes
//
//  Created by David Fisher on 7/8/14.
//  Copyright (c) 2014 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RHTemporaryMovieQuoteModelObject;

@interface RHDetailViewController : UIViewController

@property (strong, nonatomic) RHTemporaryMovieQuoteModelObject* quote;
@property (weak, nonatomic) IBOutlet UILabel* quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel* movieTitleLabel;

- (IBAction) pressedEditButton:(id)sender;


@end
