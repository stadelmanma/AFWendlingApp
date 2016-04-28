//
//  ProductSearchViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "ProductSearchViewController.h"

@interface ProductSearchViewController ()

@end

@implementation ProductSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.navigationItem.title = @"AF Wendling Product Search";
    //
    self.searchTerm = @".+";
    self.startIndex = @0;
    self.maxReturn = @20;
    self.brands = @[];
    self.categories = @[];
    self.itemsInView = @[];
    //
    NSArray *sqlArray = [FetchData buildSqlArray:self.searchTerm startIndex:self.startIndex maxReturn:self.maxReturn brandArray:self.brands categoryArray:self.categories];
    [FetchData fetchProductData:sqlArray viewDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchButtonTapped:(id)sender {
    //
    self.searchTerm = self.searchTermField.text;
    self.startIndex = @0;
    self.brands = @[];
    self.categories = @[];
    if ([self.searchTerm length] == 0) {
        self.searchTerm = @".+";
    }
    //
    NSArray *sqlArray = [FetchData buildSqlArray:self.searchTerm startIndex:self.startIndex maxReturn:self.maxReturn brandArray:@[] categoryArray:@[]];
    [FetchData fetchProductData:sqlArray viewDelegate:self];
    //
    [self.searchTermField resignFirstResponder];
}

- (void)updateCountLabel:(NSNumber *)num {
    //
    //
    self.resultsCount = num;
    //
    NSString *countString = [NSString stringWithFormat:@"%@ Results",num];
    self.resultsCountLabel.text = countString;
}

- (void)updateResultsTable:(NSMutableArray *)itemArray {
    //
    self.itemsInView = itemArray;
    [self.itemTableView reloadData];
    //
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
// table view methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //
    return [self.itemsInView count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    //
    int num = [self.startIndex intValue] + (int)indexPath.row + 1;
    Item *item = self.itemsInView[indexPath.row];
    NSString *mainLabel = [NSString stringWithFormat:@"%d. Item: %@",num,item.itemNumber];
    NSString *detailLabel = item.desc;
    //
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:item.imageUrl completionHandler:^(NSData *imageData, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (httpResponse.statusCode == 200) {
            item.image = [UIImage imageWithData:imageData];
            CGRect rect = CGRectMake(0,0,35,35);
            UIGraphicsBeginImageContext( rect.size );
            [item.image drawInRect:rect];
            item.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if (tableView) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UITableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        [updateCell.imageView setImage:item.image];;
                });
            }
        }
    }];
    [task resume];
    //
    //
    [cell.imageView setImage:item.image];
    cell.textLabel.text = mainLabel;
    cell.detailTextLabel.text = detailLabel;
    //
    return cell;
}

//
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    //
    NSArray *keyArray = [FetchData getKeyArray];
    //
    NSError *e;
    NSDictionary *returnDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:&e];
    //
    NSArray *dataArray = returnDict[keyArray[0]];
    NSArray *countArray = returnDict[keyArray[1]];
    NSArray *brands = returnDict[keyArray[2]];
    NSArray *categories = returnDict[keyArray[3]];
    //
    NSMutableArray *itemArray = [NSMutableArray array];
    int i = 0;
    for (NSDictionary *itemDict in dataArray) {
        [itemArray addObject:[[Item alloc] initWithDict:itemDict]];
        i = i + 1;
    }
    //
    //
    //[self updateBrandList:brands];
    //[self updateCategoryList:categories];
    [self updateCountLabel:countArray[0][@"COUNT(*)"]];
    [self updateResultsTable:itemArray];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@" didFailWithError: %@",error);
}

@end
