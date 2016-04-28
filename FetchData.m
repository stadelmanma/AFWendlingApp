//
//  FetchData.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "FetchData.h"

@implementation FetchData

static NSString *dataKey = @"productData";
static NSString *countKey = @"resultsCount";
static NSString *brandKey = @"productBrands";
static NSString *catKey = @"productCategories";



+(NSArray *)buildSqlArray:(NSString *)searchTerm
               startIndex:(NSNumber *)start
                maxReturn:(NSNumber*)max
               brandArray:(NSArray *)brands
            categoryArray:(NSArray *)cats {
    //
    NSMutableDictionary *sqlParams = [NSMutableDictionary new];
    NSArray *whereArray = @[
                            @[@"all",@"REGEXP",searchTerm],
                            @[@"brand", @"REGEXP", @".*"],
                            @[@"category", @"REGEXP", @".*"],
                            @[@"stock status",@"REGEXP",@"ACTIVE|NEW ITEM|SPECIAL CUT MEAT|SPECIAL"]
                            ];
    [sqlParams setValue:@"products" forKey:@"table"];
    [sqlParams setValue:@"*" forKey:@"cols"];
    [sqlParams setValue:whereArray forKey:@"where"];
    [sqlParams setValue:@[start,max] forKey:@"limit"];
    //
    NSString *dataSql = [FetchData buildSqlStatement:sqlParams];
    [sqlParams setValue:@"COUNT(*)" forKey:@"cols"];
    [sqlParams removeObjectForKey:@"limit"];
    NSString *countSql = [FetchData buildSqlStatement:sqlParams];
    [sqlParams setValue:@"`brand`" forKey:@"cols"];
    [sqlParams setValue:@"`brand`" forKey:@"groupBy"];
    NSString *bndSql = [FetchData buildSqlStatement:sqlParams];
    [sqlParams setValue:@"`category`" forKey:@"cols"];
    [sqlParams setValue:@"`category`" forKey:@"groupBy"];
    NSString *catSql = [FetchData buildSqlStatement:sqlParams];
    //
    //
    return(@[dataSql,countSql,bndSql,catSql]);
    
}

+ (NSArray *)getKeyArray {
    return @[dataKey,countKey,brandKey,catKey];
}


+(NSString *)buildSqlStatement:(NSDictionary *)sqlParams {
    //
    NSString *table = [sqlParams valueForKey:@"table"];
    NSString *cols = [sqlParams valueForKey:@"cols"];
    NSArray *where = [sqlParams valueForKey:@"where"];
    //
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM `%@`",cols,table];
    sql = [NSString stringWithFormat:@" %@ `%@`",sql,table];
    sql = [NSString stringWithFormat:@" %@ WHERE `%@` %@ '%@'",sql,where[0][0],where[0][1],where[0][2]];
    for (int i = 1; i < [where count]; i++) {
        sql = [NSString stringWithFormat:@" %@ AND `%@` %@ '%@'",sql,where[i][0],where[i][1],where[i][2]];
    }
    //
    if ([sqlParams objectForKey:@"groupBy"]) {
        NSString *group = [sqlParams valueForKey:@"groupBy"];
        sql = [NSString stringWithFormat:@" %@ GROUP BY %@ ",sql,group];
    }
    //
    if ([sqlParams objectForKey:@"limit"]) {
        NSArray *limit = [sqlParams valueForKey:@"limit"];
        sql = [NSString stringWithFormat:@" %@ LIMIT %@,%@",sql,limit[0],limit[1]];
    }
    //
    //
    return(sql);
    
}

+ (void)fetchProductData:(NSArray*)sqlArray
            viewDelegate:(UIViewController *)view {
    //
    NSData *postData = [FetchData buildPostBody:sqlArray dataKeys:[FetchData getKeyArray]];
    [FetchData sendPostRequest:postData viewDelegate:view];
}

+(NSData *)buildPostBody:(NSArray*)sqlArray
                dataKeys:(NSArray*)keyArray {
    //
    // creating post body params
    NSString *sqlStatements = [sqlArray componentsJoinedByString:@";"];
    NSString *dataKeys = [keyArray componentsJoinedByString:@";"];
    
    NSString *post = [NSString stringWithFormat:@"async_fetch=true&sql_statements=%@&return_names=%@",sqlStatements,dataKeys];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //
    return postData;
}

+ (void)sendPostRequest:(NSData *)postData viewDelegate:(UIViewController *)view {
    //
    // creating request and setting params
    NSString *postLength = [NSString stringWithFormat:@"%d",(int)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1/~Matt_Stadelman/afw-product_search/product-search/product_search.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    //
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:view];
}


@end
