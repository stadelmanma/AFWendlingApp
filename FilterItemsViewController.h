//
//  FilterItemsViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSearchViewController.h"


@interface FilterItemsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSString *searchTerm;

@property (nonatomic, strong) NSNumber *maxReturn;

@property (nonatomic, strong) NSArray *brandArray;

@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) NSArray *brandRefine;

@property (nonatomic, strong) NSArray *categoryRefine;

@property (nonatomic, weak) UIViewController *prevView;

@property (weak, nonatomic) IBOutlet UIPickerView *brandPickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;

@property int brandRow;

@property int categoryRow;

@end
