//
//  FetchData.h
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductSearchViewController.h"
#import "Item.h"

@interface FetchData : NSObject

//
//
// builds request, sends request and does inital processing to return a data array

+ (NSArray *) buildSqlArray:(NSString *)searchTerm
                 startIndex:(NSNumber *)start
                  maxReturn:(NSNumber*)max
                 brandArray:(NSArray *)brands
              categoryArray:(NSArray *)cats;

+ (NSString *) buildSqlStatement:(NSDictionary*)sqlParams;

+ (NSArray *) getKeyArray;


+ (void) fetchProductData:(NSArray*)sqlArray
             viewDelegate:(UIViewController*)view;

+ (NSData *) buildPostBody:(NSArray*)sqlArray
                  dataKeys:(NSArray*)keyArray;

+ (void) sendPostRequest:(NSData*)postData
            viewDelegate:(UIViewController*)view;

@end
