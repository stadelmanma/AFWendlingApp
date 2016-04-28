//
//  ItemDetailViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"Item: %@",self.selectedItem.itemNumber];
    [self.displayImage setImage:self.selectedItem.image];
    self.displayImage.contentMode = UIViewContentModeScaleAspectFit;
    self.detailsTextView.text = [self.selectedItem itemDetail];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
