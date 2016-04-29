//
//  ItemDetailViewController.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;

@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@property (nonatomic, strong) Item *selectedItem;

@end
