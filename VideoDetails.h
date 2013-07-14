//
//  VideoDetails.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VideoName;

@interface VideoDetails : NSManagedObject

@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) VideoName *nameRelationship;

@end
