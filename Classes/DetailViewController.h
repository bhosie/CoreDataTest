//
//  DetailViewController.h
//  CoreDataTest
//
//  Created by Brian Hosie on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UITableViewController {
	NSManagedObject *theObject;
	NSArray *myTopicNames, *myTopicURLS;
}

@property (nonatomic, retain) NSManagedObject *theObject;
@property (nonatomic, retain) NSArray	*myTopicNames;
@property (nonatomic, retain) NSArray	*myTopicURLS;

@end
