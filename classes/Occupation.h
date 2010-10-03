//
//  Occupation.h
//  CoreDataTest
//
//  Created by Brian Hosie on 10/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Topic;

@interface Occupation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet * topics;

@end

