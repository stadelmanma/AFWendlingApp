//
//  ShoppingCartTableViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "ShoppingCartTableViewController.h"
#import "ItemDetailViewController.h"

@interface ShoppingCartTableViewController ()

@end

@implementation ShoppingCartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //
}

- (void)viewWillAppear:(BOOL)animated {
    //
    self.cartItems = [ShoppingCart getCart];
    [self.cartTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //
    return [self.cartItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    //
    Item *item = self.cartItems[indexPath.row];
    NSString *mainLabel = [NSString stringWithFormat:@"Item: %@",item.itemNumber];
    NSString *detailLabel = item.desc;
    //
    UIImage *tableImage = item.image;
    CGRect rect = CGRectMake(0,0,35,35);
    UIGraphicsBeginImageContext( rect.size );
    [tableImage drawInRect:rect];
    tableImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    [cell.imageView setImage:tableImage];
    cell.textLabel.text = mainLabel;
    cell.detailTextLabel.text = detailLabel;
    //
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *item = self.cartItems[indexPath.row];
        [ShoppingCart removeItem:item];
        self.cartItems = [ShoppingCart getCart];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    // Get the new view controller using [segue destinationViewController].
    ItemDetailViewController *itemDetail = [segue destinationViewController];
    //
    // Pass the selected object to the new view controller.
    NSIndexPath *path = [self.cartTableView indexPathForCell:sender];
    Item *selectedItem = self.cartItems[path.row];
    itemDetail.selectedItem = selectedItem;
    itemDetail.segueIdentifier = segue.identifier;
}


@end
