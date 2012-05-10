//
//  webViewer.m
//  InterfaceExport
//
//  Created by David McMahon on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "webViewer.h"


@implementation webViewer

@synthesize webView,storyLink;

-(IBAction) back:(id)sender{
	
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) goback:(id)sender{
	[webView goBack];
}

-(IBAction) goforward:(id)sender{
	
	[webView goForward];
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
	
	[activityView startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
	[activityView stopAnimating];
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	
	/*NSString *path = [[NSBundle mainBundle] pathForResource:@"MarginTest" ofType:@"PDF"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];*/
	
	NSURL *url = [NSURL URLWithString:storyLink];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (YES);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}





@end

