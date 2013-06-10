//
//  HH1ViewController.m
//  HHTabList
//
//  Created by Dheeraj Kaveti on 6/10/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import "HH1ViewController.h"
#import "HHTabListController.h"
#import "HH3ViewController.h"
@interface HH1ViewController ()

@end

@implementation HH1ViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if ([self isMovingToParentViewController]) {
		HHTabListController *tabListController = [self tabListController];
		UIBarButtonItem *leftBarButtonItem = tabListController.revealTabListBarButtonItem;
		
		self.navigationItem.leftBarButtonItem = leftBarButtonItem;
	}
}
- (IBAction)didTapOnNextButton:(id)sender {
    HH3ViewController *viewController =[[HH3ViewController alloc ]init];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
