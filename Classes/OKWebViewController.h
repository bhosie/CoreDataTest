//
//  OKWebViewController.h
//  CoreDataTest
//
//  Created by Brian Hosie on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OKWebViewController : UIViewController {
		
	IBOutlet UIWebView *webView;
	IBOutlet UIButton *backButton;
	NSString *aURL, *aName; 

}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) NSString *aURL;
@property (nonatomic, retain) NSString *aName;

@end
