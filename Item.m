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

-(instancetype)initWithDict:(NSDictionary *)itemDict arrayIndex:(int)index{
    //
    self.itemData = [[NSMutableDictionary alloc] init];
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
    self.rowIndex = index;
    //
    //
    NSString *imageURL = [NSString stringWithFormat:@"http://www.afwendling.com/prodimages/%@.jpg",self.itemNumber];
    self.imageUrl = [NSURL URLWithString:imageURL];
    self.image = [UIImage imageNamed:@"coming_soon"];
    self.tempImage = [UIImage imageNamed:@"coming_soon"];
    CGRect rect = CGRectMake(0,0,35,35);
    UIGraphicsBeginImageContext( rect.size );
    [self.tempImage drawInRect:rect];
    self.tempImage = UIGraphicsGetImageFromCurrentImageContext();
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

-(NSString *)itemDetail {
    //
    NSString *detailString = @"";
    //
    detailString = [NSString stringWithFormat:@"%@Description: %@\n\n",detailString,self.desc];
    detailString = [NSString stringWithFormat:@"%@Brand: %@\n",detailString,self.brand];
    detailString = [NSString stringWithFormat:@"%@Category: %@ - %@\n\n",detailString,self.category,[self.itemData valueForKey:@"sub category"]];
    detailString = [NSString stringWithFormat:@"%@Unit: %@\n",detailString,[self.itemData valueForKey:@"unit"]];
    detailString = [NSString stringWithFormat:@"%@Pack Size %@\n",detailString,[self.itemData valueForKey:@"packsize"]];
    detailString = [NSString stringWithFormat:@"%@Weight: %@ lbs\n",detailString,[self.itemData valueForKey:@"weight"]];
    //
    return detailString;
}

@end
