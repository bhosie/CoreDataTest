//
//  Occupation.h
//  CoreDataTest
//
//  Created by Brian Hosie on 10/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Topic;

@interface Occupation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * occName;
@property (nonatomic, retain) NSNumber * clusterID;
@property (nonatomic, retain) NSSet* topics;

@end


@interface Occupation (CoreDataGeneratedAccessors)
- (void)addTopicsObject:(Topic *)value;
- (void)removeTopicsObject:(Topic *)value;
- (void)addTopics:(NSSet *)value;
- (void)removeTopics:(NSSet *)value;

@end

