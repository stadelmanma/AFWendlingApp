//
//  ItemDetailViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "ShoppingCart.h"

@interface ItemDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;

@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;

@property (nonatomic, strong) Item *selectedItem;

@property (nonatomic, strong) NSString *segueIdentifier;

- (IBAction)addToCartTapped:(id)sender;

- (void) cartButtonTapped:(UIBarButtonItem *)sender;

@end
