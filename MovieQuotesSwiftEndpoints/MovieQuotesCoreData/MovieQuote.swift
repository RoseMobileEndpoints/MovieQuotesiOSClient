//
//  MovieQuote.swift
//  MovieQuotesCoreData
//
//  Created by David Fisher on 1/23/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

class MovieQuote: NSObject {
    var quote : String
    var movie : String
    
    init(quote : String, movie : String) {
        self.quote = quote
        self.movie = movie
    }
}
