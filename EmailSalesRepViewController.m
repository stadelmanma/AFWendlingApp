//
//  EmailSalesRepViewController.m
//  AFWendlingApp
//
//  Created by Matthew Stadelman on 4/29/16.
//  Copyright (c) 2016 Matthew Stadelman. All rights reserved.
//
#import "AppDelegate.h"
#import "EmailSalesRepViewController.h"

@interface EmailSalesRepViewController ()

@end

@implementation EmailSalesRepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    //
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.topItem.title = @"Email Sales Rep";
    //
    //
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // setting up email view
    if ( [MFMailComposeViewController canSendMail] )
    {
        [appDelegate.globalMailComposer setToRecipients:
         [NSArray arrayWithObjects: @"test.rep@afwendling.com", nil] ];
        [appDelegate.globalMailComposer setSubject:@"subject"];
        [appDelegate.globalMailComposer setMessageBody:@"message" isHTML:NO];
        ///
        appDelegate.globalMailComposer.mailComposeDelegate = self;
        [self presentViewController:appDelegate.globalMailComposer
                           animated:YES completion:nil];
    }
    else
    {
        NSLog(@"Unable to mail. No email on this device.");
        [appDelegate cycleTheGlobalMailComposer];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error {
    //
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSLog(@"error %@",[error localizedDescription]);
    //
    [controller dismissViewControllerAnimated:YES completion:^
     { [appDelegate cycleTheGlobalMailComposer]; }
     ];
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
