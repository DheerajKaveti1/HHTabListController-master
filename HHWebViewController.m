//
//  HHWebViewController.m
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/2/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import "HHWebViewController.h"

@interface HHWebViewController ()

@end

@implementation HHWebViewController
@synthesize webLink;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.webLink=[self.webLink stringByReplacingOccurrencesOfString:@"watch?v=" withString:@"v/"];
//    self.webLink=[self.webLink stringByReplacingOccurrencesOfString:@"&wide=1" withString:@""];
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    NSString *html = [NSString stringWithFormat: @"<html><head>\
//                      <body style=\"margin:0\">\
//                      <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
//                      width=\"%0.0f\" height=\"%0.0f\"></embed>\
//                      </body></html>", self.webLink,screenRect.size.width+10.0,screenRect.size.height
//                      ];
//    // Load the html into the webview
//    [self.moviewebView loadHTMLString:html baseURL:nil];
    NSURL *url = [NSURL URLWithString:self.webLink];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_moviewebView loadRequest:requestObj];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMoviewebView:nil];
    [super viewDidUnload];
}
@end
