//
//  Topic.h
//  CoreDataTest
//
//  Created by Brian Hosie on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Occupation;

@interface Topic :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * tName;
@property (nonatomic, retain) NSString * tURL;
@property (nonatomic, retain) Occupation * occupation;

@end



