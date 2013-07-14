//
//  HH1ViewController.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideosData.h"
#define kUrl [NSString stringWithFormat:@"gdata.youtube.com/feeds/api/users/channel/uploads?orderby=updated"] //

@interface HH1ViewController : UITableViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext_;
@property(nonatomic,strong) NSArray *videoNamesList,*videoImageList,*videoChannelList;


@end
