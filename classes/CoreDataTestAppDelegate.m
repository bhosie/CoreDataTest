//
//  CoreDataTestAppDelegate.m
//  CoreDataTest
//
//  Created by Brent Hosie on 10/1/10.
//  Copyright University Of Utah 2010. All rights reserved.
//

#import "CoreDataTestAppDelegate.h"
#import "Occupation.h"
#import "RootViewController.h"
#import "Topic.h"


@implementation CoreDataTestAppDelegate

@synthesize window;
@synthesize navController = _navController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	//[self loadInitialData];
    // Override point for customization after application launch.
	
	NSManagedObjectContext *context = [self managedObjectContext];
	NSManagedObjectContext *contextB = [self managedObjectContext];

		
	//////********************USE ME TO INITIALIZE SOME TEST DATA. OTHERWISE COMMENT ME OUT.**********************/////
	
    
	 Occupation *occupationInfo = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"Occupation" 
                                      inManagedObjectContext:context];
	Topic *topicInfo = [NSEntityDescription
								  insertNewObjectForEntityForName:@"Topic" 
								  inManagedObjectContext:context];
	[occupationInfo setValue:@"Developer" forKey:@"occName"];
	[topicInfo setValue:@"test" forKey:@"tName"];
	[topicInfo setValue:@"http://google.com" forKey:@"tURL"];
	[NSSet setWithObjects:@"topicInfo", nil];
		
	
	////////******************************END TEST DATA CODE.*************************************************/////////
	
	/*NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error. Couldn't Save: %@", [error localizedDescription]);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Occupation" 
                                              inManagedObjectContext:context];
	
	NSFetchRequest *topicFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *topicEntity = [NSEntityDescription entityForName:@"Topic" 
                                              inManagedObjectContext:contextB];
	
	[fetchRequest setEntity:entity];
	[topicFetchRequest setEntity:topicEntity];
	
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	for (Occupation *occ in fetchedObjects) {
		NSLog(@"Name: %@", occ.occName);
		NSLog(@"Name: %@", occ.clusterID);
		}
	NSArray *fetchedTopicObjects = [contextB executeFetchRequest:topicFetchRequest error:&error];
	for (Topic *topic in fetchedTopicObjects) {
		NSLog(@"Topic Name: %@", topic.tName);
		NSLog(@"Topic URL: %@", topic.tURL);
	}
	
	
    [fetchRequest release];
	[topicFetchRequest release];
	*/
    //Root View Controller
    RootViewController *root = (RootViewController *) [_navController topViewController];
    root.context = [self managedObjectContext];
    [window addSubview:_navController.view];	
	
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)loadInitialData
{
	//Confirm method is running	
    NSLog(@"loadInitialData launched");
	
	
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];//[[NSManagedObjectContext alloc] init];
    //[context setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"txt"];
	NSString* string = [[NSString alloc] initWithContentsOfFile:path];
    NSArray *parts = [string componentsSeparatedByString:@";"];
	
	NSString *occ, *clus, *top, *topURL;
	for(int i = 0; i < [parts count]; i+=34)
	{
		occ = [parts objectAtIndex:i];
		clus = [parts objectAtIndex:i+1];
		
		Occupation *occupation = [NSEntityDescription
								  insertNewObjectForEntityForName:@"Occupation" 
								  inManagedObjectContext:context];	
		
		
		[occupation setValue:(@"%@", occ) forKey:@"occName"];
		[occupation setValue:(@"%@", clus) forKey:@"clusterID"];
		
		NSMutableArray *allTopics = [[NSMutableArray alloc] initWithCapacity:16];
		for(int j = i+2; j < i+34; j+=2) // Topics Loop
		{
			// Grab a single topic and its URL 
			top = [parts objectAtIndex:j];
			topURL = [parts objectAtIndex:j+1];
			
			// Create topic instance, populate its fields
			Topic *topic = [NSEntityDescription
							insertNewObjectForEntityForName:@"Topic" 
							inManagedObjectContext:context];			
			[topic setValue:(@"%@", top) forKey:@"tName"];
			[topic setValue:(@"%@", topURL) forKey:@"tURL"];
			
			// Shove it into the NSSet
			[allTopics addObject:topic];
			//[topic release];
			
			//NSLog(@"%i ENTRY IS: %@, %@, %@, %@ \n------------------------------", i, occ, clus, top, topURL);
		}
		
		NSSet *a = [NSSet setWithArray:allTopics];
		//NSLog(@"%@", a);
		[occupation setValue:a forKey:@"topics"];	
		//NSLog(@"%@", occupation);
		
		//[occupation release];
		
	}
	NSError *error = nil; 
	[context save:&error];
    
    [string release];		
    [context release];
    [pool drain];
	
	NSLog(@"ALL DONE");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CoreDataTest" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"CoreDataTest.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [window release];
	[_navController release];	
    [super dealloc];
}


@end

