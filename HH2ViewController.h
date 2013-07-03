//
//  HH2ViewController.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 6/10/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HHTabListController.h"
@interface HH2ViewController : UITableViewController
@property (strong, nonatomic) NSFetchedResultsController  *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext_;
@end
