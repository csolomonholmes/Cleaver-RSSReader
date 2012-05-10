//
//  RSSReader.h
//  ePhysics
//
//  Created by David McMahon on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 


@interface RSSReader : UIViewController {
	
	IBOutlet UITableView *newsTable;
	IBOutlet UIActivityIndicatorView *activityView;
	
	UIActivityIndicatorView *activityIndicator;
	
	CGSize cellSize;
	
	NSXMLParser * rssParser;
	
	NSMutableArray * stories;
	
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink, *currentimage;

}

@property(nonatomic,retain) IBOutlet UITableView *newsTable;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityView;
@property NSInteger hasImages;
@property NSString *path;

-(IBAction) back:(id)sender;

@end
