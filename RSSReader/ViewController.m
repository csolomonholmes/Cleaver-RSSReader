//
//  ViewController.m
//  RSSReader
//
//  Created by David McMahon on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "RSSReader.h"

@interface ViewController (){
    
    NSString *NewsPage;
}

@end

@implementation ViewController

-(IBAction)openYahooFinance:(id)sender{
    
    NewsPage = @"http://finance.yahoo.com/rss/topfinstories";
    RSSReader *storyList = [[RSSReader alloc] initWithNibName:nil bundle:nil];
    storyList.path = NewsPage;
    [self presentModalViewController:storyList animated:YES];
    
    
}

-(IBAction)openWalterWilliams:(id)sender{
    
    NewsPage = @"http://rss.townhall.com/columnists/WalterEWilliams";
    RSSReader *storyList = [[RSSReader alloc] initWithNibName:nil bundle:nil];
    storyList.path = NewsPage;
    [self presentModalViewController:storyList animated:YES];
    
}

-(IBAction)openCNN:(id)sender{
    
    NewsPage = @"http://rss.cnn.com/rss/edition.rss";
    RSSReader *storyList = [[RSSReader alloc] initWithNibName:nil bundle:nil];
    storyList.path = NewsPage;
    [self presentModalViewController:storyList animated:YES];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NewsPage = [[NSString alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
