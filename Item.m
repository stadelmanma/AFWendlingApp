//
//  Item.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "Item.h"

@implementation Item

//
// Stores item information
//

-(instancetype)initWithDict:(NSDictionary *)itemDict {
    //
    [self.itemData setValuesForKeysWithDictionary:itemDict];
    //
    NSArray *prop_map = @[
                          @[@"itemNumber",@"item number"],
                          @[@"desc",@"descript"],
                          @[@"brand",@"brand"],
                          @[@"category",@"category"]
                          ];
    //
    for (NSArray *map in prop_map) {
        [self setValue:itemDict[map[1]] forKey:map[0]];
    }
    //
    //
    NSString *imageURL = [NSString stringWithFormat:@"http://www.afwendling.com/prodimages/%@.jpg",self.itemNumber];
    self.imageUrl = [NSURL URLWithString:imageURL];
    self.image = [UIImage imageNamed:@"coming_soon"];
    CGRect rect = CGRectMake(0,0,35,35);
    UIGraphicsBeginImageContext( rect.size );
    [self.image drawInRect:rect];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    //
    return self;
}

- (NSString *)description {
    //
    return [NSString stringWithFormat:@"Item Number: %@ \n%@ \nBrand: %@\nCategory: %@",
            self.itemNumber,self.desc,self.brand,self.category];
}


@end
