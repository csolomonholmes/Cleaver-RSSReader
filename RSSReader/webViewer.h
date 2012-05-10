//
//  webViewer.h
//  InterfaceExport
//
//  Created by David McMahon on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface webViewer : UIViewController {
	
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *activityView;

}

@property(nonatomic,retain) IBOutlet UIWebView *webView;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityView;

@property NSString *storyLink;

-(IBAction) back:(id)sender;
-(IBAction) goforward:(id)sender;
-(IBAction) goback:(id)sender;

@end
