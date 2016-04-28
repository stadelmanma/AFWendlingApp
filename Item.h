//
//  Item.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *itemNumber;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSMutableDictionary *itemData;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *tempImage;
@property (nonatomic, strong) NSURL *imageUrl;
@property  int rowIndex;

-(instancetype) initWithDict:(NSDictionary *) itemDict arrayIndex:(int)index;

-(NSString *) description;

-(NSString *) itemDetail;

@end
