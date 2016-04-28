//
//  FilterItemsViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSearchViewController.h"


@interface FilterItemsViewController : UIViewController <UIPickerViewDataSource>

@property (nonatomic, strong) NSString *searchTerm;

@property (nonatomic, strong) NSNumber *maxReturn;

@property (nonatomic, strong) NSArray *brandArray;

@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) NSString *selectedBrand;

@property (nonatomic, strong) NSString *selectedCategory;

@property (weak, nonatomic) IBOutlet UIPickerView *brandPickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;

@end
