/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//
//  Created by Randy McMillan on 5/9/12.
//  Copyright OpenOSX.org 2012. All rights reserved.
//

#import "ViewController.h"
#import "CleaverReader.h"
#import "cleaverViewController.h"
@interface ViewController (){
    
    NSString *NewsPage;
}

@end

@implementation ViewController

-(IBAction)openPhoneGapFeed:(id)sender{
    
    NewsPage = @"http://phonegap.com/feed/";
    CleaverReader *storyList = [[CleaverReader alloc] initWithNibName:nil bundle:nil];
    storyList.path = NewsPage;
    [self presentModalViewController:storyList animated:YES];
    
    
}

-(IBAction)openJiraIssueTracker:(id)sender{
    
    NewsPage = @"https://issues.apache.org/jira/sr/jira.issueviews:searchrequest-xml/temp/SearchRequest.xml?jqlQuery=project+%3D+CB+AND+resolution+%3D+Unresolved+AND+component+%3D+iOS+ORDER+BY+priority+DESC&tempMax=1000";
    CleaverReader *storyList = [[CleaverReader alloc] initWithNibName:nil bundle:nil];
    storyList.path = NewsPage;
    [self presentModalViewController:storyList animated:YES];
    
}



-(IBAction)openCleaverView:(id)sender{
        
    CDVViewController* cleaverViewController = [CDVViewController new];
    cleaverViewController.wwwFolderName = @"www";
    cleaverViewController.startPage = @"index.html";
    
    CGRect viewBounds = [[UIScreen mainScreen] bounds];
    int x = 100;//viewBounds.size.width * .5;
    int y = viewBounds.size.width * .5;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self 
               action:@selector(closeCleaverView:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Close Cleaver View" forState:UIControlStateNormal];
    button.frame = CGRectMake(x, y, 160.0, 40.0);
    button.center = cleaverViewController.view.center ;
    [cleaverViewController.view addSubview:button];
    [self presentModalViewController:cleaverViewController animated:YES];
 
}

-(void)closeCleaverView:(id)sender{

    [self dismissModalViewControllerAnimated:YES];
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
    return NO;//(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
