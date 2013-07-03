//
//  HHGoogleParser.h
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/2/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define kMoviesUrl [NSURL URLWithString:@"https://spreadsheets.google.com/feeds/list/0Asafdw5Ra2Q9dGRSVkYtbWZWWUFBMS1WeFA1VHFPU1E/od6/public/basic?alt=rss"]
@interface HHGoogleParser : NSObject<NSXMLParserDelegate>
@property(nonatomic,retain)    NSXMLParser *parser;
@property(nonatomic,retain)    NSMutableString *current;
@property(nonatomic,retain) NSString *ititle,*imovieImage,*iLink;
@property(nonatomic,retain)NSMutableData *webRequest;
-(void)parsingXml;

@property (strong, nonatomic) NSFetchedResultsController  *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext_;

@end
