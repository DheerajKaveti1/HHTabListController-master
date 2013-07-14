//
//  VideoName.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VideoDetails;

@interface VideoName : NSManagedObject

@property (nonatomic, retain) NSString * channelName;
@property (nonatomic, retain) NSSet *detailsrelationship;
@end

@interface VideoName (CoreDataGeneratedAccessors)

- (void)addDetailsrelationshipObject:(VideoDetails *)value;
- (void)removeDetailsrelationshipObject:(VideoDetails *)value;
- (void)addDetailsrelationship:(NSSet *)values;
- (void)removeDetailsrelationship:(NSSet *)values;

@end
