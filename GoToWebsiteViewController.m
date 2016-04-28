//
//  GoToWebsiteViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/28/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//

#import "GoToWebsiteViewController.h"

@interface GoToWebsiteViewController ()

@end

@implementation GoToWebsiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    NSURL *url = [NSURL URLWithString: @"http://www.afwendling.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"loading..");
    [self.webViewLoadingIndicator startAnimating];
    [self.webView loadRequest:request];
    NSLog(@"done");
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webViewLoadingIndicator stopAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
