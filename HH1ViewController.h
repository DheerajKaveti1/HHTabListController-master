//
//  HH1ViewController.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD
#import "VideosData.h"
#define kUrl [NSString stringWithFormat:@"gdata.youtube.com/feeds/api/users/channel/uploads?orderby=updated"] //
=======
#import <CoreData/CoreData.h>
#import "DAPagesContainer.h"
>>>>>>> 9d9b89e043e5b8a9c347c33c1598975d70911632

@interface HH1ViewController : UITableViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext_;
@property(nonatomic,strong) NSArray *videoNamesList,*videoImageList,*videoChannelList;


@end
