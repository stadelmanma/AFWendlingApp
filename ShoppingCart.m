//
//  ShoppingCart.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "ShoppingCart.h"

@implementation ShoppingCart

static NSString *storageKey = @"AFW-USER-SHOPPING-CART";
//
static ShoppingCart *instance =nil;
+(ShoppingCart *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance = [ShoppingCart new];
            instance.cartItems = [[NSMutableArray alloc] init];
        }
    }
    return instance;
}

+ (NSArray *)getCart {
    //
    ShoppingCart *cart = [ShoppingCart getInstance];
    return [cart.cartItems copy];
}

+ (void)saveCart {
    //
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSArray *cartItems = [ShoppingCart getCart];
    for (Item *item in cartItems) {
        [dataArray addObject:item.itemData];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:storageKey];
}

+ (void)loadCart {
    //
    NSArray *cartData = [[NSUserDefaults standardUserDefaults] valueForKey:storageKey];
    for (NSDictionary *itemData in cartData) {
        Item *item = [[Item alloc] initWithDict:itemData arrayIndex:-1];
        [item asyncGetImage];
        [ShoppingCart addItem:item];
    }
}

+ (void)addItem:(Item *)item {
    //
    ShoppingCart *cart = [ShoppingCart getInstance];
    [cart.cartItems addObject:item];
}

+ (void)removeItem:(Item *)item {
    //
    ShoppingCart *cart = [ShoppingCart getInstance];
    [cart.cartItems removeObject:item];
}

@end
