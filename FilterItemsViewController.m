//
//  FilterItemsViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "FilterItemsViewController.h"

@interface FilterItemsViewController ()

@end

@implementation FilterItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"Filter Search Results";
    self.brandArray = [@[@"All"] arrayByAddingObjectsFromArray:self.brandArray];
    self.categoryArray = [@[@"All"] arrayByAddingObjectsFromArray:self.categoryArray];
    self.selectedBrand = @".*";
    self.selectedCategory = @".*";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    //
    ProductSearchViewController *searchView = [segue destinationViewController];
    searchView.searchTerm = self.searchTerm;
    searchView.maxReturn = self.maxReturn;
    searchView.brandRefine = @[self.selectedBrand];
    searchView.categoryRefine = @[self.selectedCategory];
    searchView.startIndex = @0;
    searchView.itemsInView = @[];
    searchView.brands = self.brandArray;
    searchView.categories = self.categoryArray;
    //
    NSArray *sqlArray = [FetchData buildSqlArray:searchView.searchTerm startIndex:searchView.startIndex maxReturn:searchView.maxReturn brandArray:searchView.brandRefine categoryArray:searchView.categoryRefine];
    [FetchData fetchProductData:sqlArray viewDelegate:searchView];
}
//
// picker view methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    //
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //
    int numRows = 0;
    //
    if([pickerView isEqual: self.brandPickerView]){
        // return the appropriate number of components, for instance
        numRows = (int)[self.brandArray count];
    }
    
    if([pickerView isEqual: self.categoryPickerView]){
        // return the appropriate number of components, for instance
        numRows = (int)[self.categoryArray count];
    }
    //
    return numRows;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //
    NSString *rowTitle = @"Error";
    //
    if([pickerView isEqual: self.brandPickerView]){
        // return the appropriate number of components, for instance
        rowTitle = self.brandArray[row];
    }
    
    if([pickerView isEqual: self.categoryPickerView]){
        // return the appropriate number of components, for instance
        rowTitle = self.categoryArray[row];
    }
    return rowTitle;
    
}
@end
