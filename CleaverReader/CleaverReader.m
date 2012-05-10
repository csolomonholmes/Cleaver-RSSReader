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

#import "CleaverReader.h"
#import "webViewer.h"


@implementation CleaverReader
@synthesize hasImages,path,activityView,newsTable;

-(IBAction) back:(id)sender{
	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
	// Add the following line if you want the list to be editable
	// self.navigationItem.leftBarButtonItem = self.editButtonItem;
	[activityView startAnimating];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1; 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [stories count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
	if(hasImages == 1)
		return 95;
	else
		return 125;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView 
							 dequeueReusableCellWithIdentifier:CellIdentifier];
	
	
	
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
				 
		CGRect frame;
		frame.origin.x = 10;
		frame.origin.y = 5;
		frame.size.height = 75;
		frame.size.width = 300;
		
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
		titleLabel.tag = 1;
		//[titleLabel setColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), blue)];
		[titleLabel setTextColor:[UIColor blueColor]]; // Foreground color
		[cell.contentView addSubview:titleLabel];
		
		if(hasImages == 0){
		  frame.origin.y += 48;
		  UILabel *summaryLabel = [[UILabel alloc] initWithFrame:frame];
		  summaryLabel.tag = 2;
		  [cell.contentView addSubview:summaryLabel];
		 
		}
    }
	
	
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	UILabel * titleLabel = (UILabel *) [cell.contentView viewWithTag:1];
	//titleLabel.numberOfLines = 0;
	titleLabel.text = [[stories objectAtIndex: storyIndex] objectForKey: @"title"];
    if(hasImages  == 0)
	{
	  UILabel * summaryLabel = (UILabel *) [cell.contentView viewWithTag:2];
		summaryLabel.numberOfLines = 44;
		summaryLabel.lineBreakMode = UILineBreakModeWordWrap; 
	  summaryLabel.text = [[stories objectAtIndex: storyIndex] objectForKey: @"summary"]; 
		
	}
		
	
	
	// Set up the cell
	//int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	//[cell setText:[[stories objectAtIndex: storyIndex] objectForKey: @"title"]];
	
	return cell;
}


//###################### code to open web page #####################################

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	
	
	webViewer *myBrowser = [[webViewer alloc] initWithNibName:nil bundle:nil];
    
    myBrowser.storyLink = [[stories objectAtIndex: storyIndex] objectForKey: @"link"];
	
	// clean up the link - get rid of spaces, returns, and tabs...
	myBrowser.storyLink = [myBrowser.storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	myBrowser.storyLink = [myBrowser.storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	myBrowser.storyLink = [myBrowser.storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
    
	[self presentModalViewController:myBrowser animated:YES];
	
	
	
}

//*******************************************************************************

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[activityView stopAnimating];
	
	if ([stories count] == 0) {
		
		
		
		
		[self parseXMLFileAtURL:path];
	}
	
	cellSize = CGSizeMake([newsTable bounds].size.width, 360);
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}




- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	stories = [[NSMutableArray alloc] init];
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		
		[stories addObject:[item copy]];
		
	}
	
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[newsTable reloadData];
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}






@end
