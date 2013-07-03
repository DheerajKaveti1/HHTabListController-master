//
//  HHWebViewController.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/2/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *moviewebView;
@property (nonatomic,strong) NSString *webLink;
@end
