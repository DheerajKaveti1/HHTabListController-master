//
//  HHChannelVideosViewController.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "VideoName.h"
#import "AFNetworking.h"

@interface HHChannelVideosViewController : UITableViewController
@property(nonatomic,strong) NSString *channelName;
@property (nonatomic,strong) NSArray *videosList;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end
