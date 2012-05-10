//
//  ViewController.m
//  RSSReader
//
//  Created by David McMahon on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "RSSReader.h"
#import "cleaverViewController.h"
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


-(IBAction)openCleaverView:(id)sender{
        
    CDVViewController* cleaverViewController = [CDVViewController new];
    cleaverViewController.wwwFolderName = @"www";
    cleaverViewController.startPage = @"index.html";
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self 
               action:@selector(closeCleaverView:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [cleaverViewController.view addSubview:button];
    
    
    [self presentModalViewController:cleaverViewController animated:YES];
 
}

-(void)closeCleaverView:(id)sender{


    NSLog(@"closeCleaverView");

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
    return YES;//(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
