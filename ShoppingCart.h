//
//  ShoppingCart.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ShoppingCart : NSObject

@property(nonatomic,retain) NSMutableArray *cartItems;

+ (ShoppingCart *)getInstance;

+ (NSArray *) getCart;

+ (void) saveCart;

+ (void) loadCart;

+ (void) addItem:(Item *)item;

+ (void) removeItem:(Item *)item;



@end
