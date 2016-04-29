//
//  ShoppingCart.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "ShoppingCart.h"

@implementation ShoppingCart

@synthesize cartItems;
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

- (void)addItem:(Item *)item {
    //
    [self.cartItems addObject:item];
}

- (void)removeItem:(Item *)item {
    //
    [self.cartItems removeObject:item];
}

- (NSArray *)getCart {
    //
    return [self.cartItems copy];
}

@end
