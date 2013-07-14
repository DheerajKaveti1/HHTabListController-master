//
//  VideosData.h
//  Shealth
//
//  Created by Dheeraj kaveti on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class AFImageCache;

@interface VideosData :NSObject<NSXMLParserDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSMutableString *current,*current2;
}
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)NSMutableString *current,*current2;
@property(strong,nonatomic)NSXMLParser *parser;
@property (strong,nonatomic)NSString *question,*answer,*neuroid,*channel;
-(void)neuroparser:(NSString *)channleName;
@end
