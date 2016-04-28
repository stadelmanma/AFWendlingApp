//
//  ProductSearchViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchData.h"
#import "Item.h"


@interface ProductSearchViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTermField;

@property (weak, nonatomic) IBOutlet UILabel *resultsCountLabel;

@property (weak, nonatomic) IBOutlet UITableView *itemTableView;

@property (nonatomic, strong) NSString *searchTerm;

@property (nonatomic, strong) NSArray  *brands;

@property (nonatomic, strong) NSArray  *categories;

@property (nonatomic, strong) NSArray *itemsInView;

@property (nonatomic, strong) NSNumber *resultsCount;

@property (nonatomic, strong) NSNumber *startIndex;

@property (nonatomic, strong) NSNumber *maxReturn;

@property (nonatomic, strong) NSMutableData *responseData;

- (IBAction)searchButtonTapped:(id)sender;

- (void) updateResultsTable:(NSMutableArray *)itemArray;

@end
