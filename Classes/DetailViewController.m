//
//  DetailViewController.m
//  CoreDataTest
//
//  Created by Brian Hosie on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "Occupation.h"
#import "Topic.h"
#import "OKWebViewController.h"


@implementation DetailViewController

@synthesize theObject;
@synthesize myTopicNames, myTopicURLS;


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	[super viewDidLoad];
	
	//Create an array of Topics for theObject and retain for use across the class
	myTopicNames = [[theObject valueForKeyPath:@"topics.tName"] allObjects];
	[myTopicNames retain];
	
	self.title = (@"Topics");
	
    

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
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	return [myTopicNames count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

	//myTopicNames = [[theObject valueForKeyPath:@"topics.tName"] allObjects];
	cell.textLabel.text = [myTopicNames objectAtIndex:indexPath.row];
    return cell;
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate


//TODO: Pass the selected topic URL to the OKWebViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Navigation logic goes here. Create and push another view controller.
	
	//Grab the URLS for the Topics of the Current Occupation
	myTopicURLS = [[theObject valueForKeyPath:@"topics.tURL"] allObjects];

	//Store the selected Topic's URL and Name
	NSString *aURL = [myTopicURLS objectAtIndex:indexPath.row];
	NSString *aName = [myTopicNames objectAtIndex:indexPath.row];
	
	//Initialize the next view controller and pass the URL and Name
	OKWebViewController *webViewController = [[OKWebViewController alloc] initWithNibName:@"OKWebViewController" bundle:nil];
	webViewController.aURL = aURL; //loads in webView
	webViewController.aName = aName; //displays topic name in OKWebViewController's title bar
		NSLog(@"aName: %@", aName);
	
	//Push the webViewController onto the stack
	[self.navigationController pushViewController:webViewController animated:YES];
	
	 [webViewController release];
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[myTopicNames release];
}


- (void)dealloc {
    [super dealloc];
	
}


@end

