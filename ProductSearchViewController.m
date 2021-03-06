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
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    //
    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shopping_cart"] style:UIBarButtonItemStylePlain target:self action:@selector(cartButtonTapped:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = cartButton;
    //
    self.searchTerm = @".+";
    self.brandRefine = @[@".*"];
    self.categoryRefine = @[@".*"];
    self.startIndex = @0;
    self.maxReturn = @20;
    self.brands = @[];
    self.categories = @[];
    self.itemsInView = @[];
    self.brandRow = 0;
    self.categoryRow = 0;
    self.setRefinementArrays = YES;
    //
    NSArray *sqlArray = [FetchData buildSqlArray:self.searchTerm startIndex:self.startIndex maxReturn:self.maxReturn brandArray:self.brandRefine categoryArray:self.categoryRefine];
    [FetchData fetchProductData:sqlArray viewDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.topItem.title = @"AF Wendling Product Catalog";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissKeyboard {
    [self.searchTermField resignFirstResponder];
}

- (void)cartButtonTapped:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"goToCart" sender:nil];
}

- (void)searchButtonTapped:(id)sender {
    //
    self.searchTerm = self.searchTermField.text;
    self.brandRefine = @[@".*"];
    self.categoryRefine = @[@".*"];
    self.startIndex = @0;
    self.brands = @[];
    self.categories = @[];
    if ([self.searchTerm length] == 0) {
        self.searchTerm = @".+";
    }
    self.itemsInView = @[];
    self.brandRow = 0;
    self.categoryRow = 0;
    self.setRefinementArrays = YES;
    //
    NSArray *sqlArray = [FetchData buildSqlArray:self.searchTerm startIndex:self.startIndex maxReturn:self.maxReturn brandArray:self.brandRefine categoryArray:self.categoryRefine];
    [FetchData fetchProductData:sqlArray viewDelegate:self];
    //
    [self.searchTermField resignFirstResponder];
}

- (void)refineResults {
    //
    self.startIndex = @0;
    self.itemsInView = @[];
    //
    NSArray *sqlArray = [FetchData buildSqlArray:self.searchTerm startIndex:self.startIndex maxReturn:self.maxReturn brandArray:self.brandRefine categoryArray:self.categoryRefine];
    [FetchData fetchProductData:sqlArray viewDelegate:self];
    //
}

- (void) loadMoreItems {
    //
    // returnig early if there are no more items to display
    int start = [self.startIndex intValue]+20;
    if (start >= [self.resultsCount intValue]) {
        return;
    }
    self.startIndex = [NSNumber numberWithInt:start];
    self.loadingData = YES; //setting this here as well because these scroll events can trigger fast
    //
    NSArray *sqlArray = [FetchData buildSqlArray:self.searchTerm startIndex:self.startIndex maxReturn:self.maxReturn brandArray:self.brandRefine categoryArray:self.categoryRefine] ;
    [FetchData fetchProductData:sqlArray viewDelegate:self];
}

- (void)updateBrandList:(NSArray *)brands {
    //
    NSMutableArray *bnds = [[NSMutableArray alloc] init];
    for (NSDictionary *entry in brands) {
        [bnds addObject:[entry valueForKey:@"brand"]];
    }
    //
    self.brands = [bnds copy];
}

- (void)updateCategoryList:(NSArray *)catagories {
    //
    NSMutableArray *cats = [[NSMutableArray alloc] init];
    for (NSDictionary *entry in catagories) {
        [cats addObject:[entry valueForKey:@"category"]];
    }
    //
    self.categories = [cats copy];
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
    self.itemsInView = [self.itemsInView arrayByAddingObjectsFromArray:itemArray];
    [self.itemTableView reloadData];
    self.loadingData = NO;
    [self.itemsLoadingIndicator stopAnimating];
    //
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //
    if ([segue.identifier isEqualToString:@"filterResults"]) {
        //
        FilterItemsViewController *filterView = [segue destinationViewController];
        filterView.prevView = self;
        filterView.searchTerm = self.searchTerm;
        filterView.maxReturn = self.maxReturn;
        filterView.brandArray = self.brands;
        filterView.categoryArray = self.categories;
        filterView.brandRefine = self.brandRefine;
        filterView.categoryRefine = self.categoryRefine;
        filterView.brandRow = self.brandRow;
        filterView.categoryRow = self.categoryRow;
    }
    else if ([segue.identifier isEqualToString:@"goToCart"]) {
        //
        
    }
    else {
        //
        // Get the new view controller using [segue destinationViewController].
        ItemDetailViewController *itemDetail = [segue destinationViewController];
        //
        // Pass the selected object to the new view controller.
        NSIndexPath *path = [self.itemTableView indexPathForCell:sender];
        Item *selectedItem = self.itemsInView[path.row];
        itemDetail.selectedItem = selectedItem;
        itemDetail.segueIdentifier = segue.identifier;
    }
}

//
// text field methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchButtonTapped:nil];
    return YES;
}


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
    Item *item = self.itemsInView[indexPath.row];
    NSString *mainLabel = [NSString stringWithFormat:@"%d. Item: %@",item.rowIndex+1,item.itemNumber];
    NSString *detailLabel = item.desc;
    //
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:item.imageUrl completionHandler:^(NSData *imageData, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (httpResponse.statusCode == 200) {
            item.image = [UIImage imageWithData:imageData];
            UIImage *tableImage = [UIImage imageWithData:imageData];
            //
            CGRect rect = CGRectMake(0,0,35,35);
            UIGraphicsBeginImageContext( rect.size );
            [tableImage drawInRect:rect];
            tableImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            if (tableView) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UITableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        [updateCell.imageView setImage:tableImage];
                });
            }
        }
    }];
    [task resume];
    //
    //
    [cell.imageView setImage:item.tempImage];
    cell.textLabel.text = mainLabel;
    cell.detailTextLabel.text = detailLabel;
    //
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    //
    if (self.loadingData == YES) {
        return;
    }
    //
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    //
    float reload_distance = -20;
    if(y > h + reload_distance) {
        [self loadMoreItems];
    }
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
    int i = [self.startIndex intValue];
    for (NSDictionary *itemDict in dataArray) {
        [itemArray addObject:[[Item alloc] initWithDict:itemDict arrayIndex:i]];
        i = i + 1;
    }
    //
    // only parsing refinement arrays when the search button is tapped
    if (self.setRefinementArrays == YES) {
        [self updateBrandList:brands];
        [self updateCategoryList:categories];
        self.setRefinementArrays = NO;
    }
    [self updateCountLabel:countArray[0][@"COUNT(*)"]];
    [self updateResultsTable:itemArray];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    self.loadingData = NO;
    [self.itemsLoadingIndicator stopAnimating];
    NSLog(@" didFailWithError: %@",error);
}

@end
