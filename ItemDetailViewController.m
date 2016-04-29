//
//  ItemDetailViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ShoppingCartTableViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = [NSString stringWithFormat:@"Item: %@",self.selectedItem.itemNumber];
    //
    if ([self.segueIdentifier isEqualToString:@"toItemDetails"]) {
        //
        // adding shopping cart button
        UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shopping_cart"] style:UIBarButtonItemStylePlain target:self action:@selector(cartButtonTapped:)];
        self.navigationItem.rightBarButtonItem = cartButton;
    }
    //
    [self.displayImage setImage:self.selectedItem.image];
    self.displayImage.contentMode = UIViewContentModeScaleAspectFit;
    self.detailsTextView.text = [self.selectedItem itemDetail];
    //
    // checking if item is already in cart
    ShoppingCart *cart = [ShoppingCart getInstance];
    if ([cart.cartItems containsObject:self.selectedItem]) {
        //
        // changing button
        [self.addToCartButton setTitle:@"Remove From Cart" forState:UIControlStateNormal];
        self.addToCartButton.tag = 100;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToCartTapped:(id)sender {
    //
    ShoppingCart *cart= [ShoppingCart getInstance];
    if (self.addToCartButton.tag == 100) {
        [cart removeItem:self.selectedItem];
        //
        // changing button
        [self.addToCartButton setTitle:@"Add To Cart" forState:UIControlStateNormal];
        self.addToCartButton.tag = 0;
    }
    else {
        [cart addItem:self.selectedItem];
        //
        // changing button
        [self.addToCartButton setTitle:@"Remove From Cart" forState:UIControlStateNormal];
        self.addToCartButton.tag = 100;
    }
    //
}

- (void)cartButtonTapped:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"goToCart" sender:nil];
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
}
*/
@end
