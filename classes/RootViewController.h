//
//  RootViewController.h
//  CoreDataTest
//
//  Created by Brent Hosie on 10/1/10.
//  Copyright 2010 University Of Utah. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UITableViewController {
	//UINavigationController *navController;
	NSArray *occupationInfo;
	NSArray *topicInfo;
	NSManagedObjectContext *context;
}

//@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) NSArray *occupationInfo;
@property (nonatomic, retain) NSArray *topicInfo;
@property (nonatomic, retain) NSManagedObjectContext *context;

@end
