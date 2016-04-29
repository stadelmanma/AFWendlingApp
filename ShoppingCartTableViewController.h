//
//  ShoppingCartTableViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCart.h"

@interface ShoppingCartTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *cartTableView;

@property (nonatomic, strong) NSArray *cartItems;

@end
