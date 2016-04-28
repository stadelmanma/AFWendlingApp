//
//  ProductSearchViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterItemsViewController.h"
#import "ItemDetailViewController.h"
#import "FetchData.h"
#import "Item.h"

@interface ProductSearchViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTermField;

@property (weak, nonatomic) IBOutlet UILabel *resultsCountLabel;

@property (weak, nonatomic) IBOutlet UITableView *itemTableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *itemsLoadingIndicator;

@property (nonatomic, strong) NSString *searchTerm;

@property (nonatomic, strong) NSArray  *brands;

@property (nonatomic, strong) NSArray  *categories;

@property (nonatomic, strong) NSArray *brandRefine;

@property (nonatomic, strong) NSArray *categoryRefine;

@property (nonatomic, strong) NSArray *itemsInView;

@property (nonatomic, strong) NSNumber *resultsCount;

@property (nonatomic, strong) NSNumber *startIndex;

@property (nonatomic, strong) NSNumber *maxReturn;

@property (nonatomic, strong) NSMutableData *responseData;

@property bool loadingData;

@property bool setRefinementArrays;

- (IBAction)searchButtonTapped:(id)sender;

- (void) dismissKeyboard;

- (void) loadMoreItems;

- (void) updateBrandList:(NSArray *)brands;

- (void) updateCategoryList:(NSArray *)catagories;

- (void) updateCountLabel:(NSNumber *)num;

- (void) updateResultsTable:(NSMutableArray *)itemArray;

@end
