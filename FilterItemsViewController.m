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
    self.brandPickerView.tag = 100;
    self.categoryPickerView.tag = 200;
    //
    [self.brandPickerView selectRow:self.brandRow inComponent:0 animated:YES];
    [self.categoryPickerView selectRow:self.categoryRow inComponent:0 animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated {
    //
    ProductSearchViewController *searchView = self.prevView;
    //
    searchView.startIndex = @0;
    searchView.itemsInView = @[];
    searchView.brandRefine = self.brandRefine;
    searchView.categoryRefine = self.categoryRefine;
    searchView.brandRow = self.brandRow;
    searchView.categoryRow = self.categoryRow;
    //
    NSArray *sqlArray = [FetchData buildSqlArray:searchView.searchTerm startIndex:searchView.startIndex maxReturn:searchView.maxReturn brandArray:searchView.brandRefine categoryArray:searchView.categoryRefine];
    [FetchData fetchProductData:sqlArray viewDelegate:searchView];
    
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    //
    NSLog(@"%@",segue.identifier);
}
*/
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
    if(pickerView.tag == 100){
        // return the appropriate number of components, for instance
        rowTitle = self.brandArray[row];
    }
    
    if(pickerView.tag == 200){
        // return the appropriate number of components, for instance
        rowTitle = self.categoryArray[row];
    }
    return rowTitle;    
}

//
//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
    if(pickerView.tag == 100){
        // return the appropriate number of components, for instance
        NSString *selectedBrand = self.brandArray[row];
        if ([selectedBrand isEqualToString:@"All"]) {
            selectedBrand = @".*";
        }
        self.brandRefine = @[selectedBrand];
        self.brandRow = (int)row;
    }
    
    if(pickerView.tag == 200){
        // return the appropriate number of components, for instance
        NSString *selectedCategory = self.categoryArray[row];
        if ([selectedCategory isEqualToString:@"All"]) {
            selectedCategory = @".*";
        }
        self.categoryRefine = @[selectedCategory];
        self.categoryRow = (int)row;
    }
}

@end
