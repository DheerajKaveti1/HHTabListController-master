//
//  HHGoogleParser.m
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/2/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import "HHGoogleParser.h"

@implementation HHGoogleParser
@synthesize parser=goParser;
@synthesize current=_current;
@synthesize imovieImage,iLink,ititle;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext_;
@synthesize webRequest;

-(void)parsingXml{
    
    goParser = [[NSXMLParser alloc] initWithContentsOfURL:kMoviesUrl];
    //    NSString *string =[[NSString alloc] initWithBytes: [WebData mutableBytes] length:[WebData length] encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",string);
	[goParser setDelegate: self];
	[goParser setShouldProcessNamespaces: NO];
	[goParser setShouldReportNamespacePrefixes:NO];
	[goParser setShouldResolveExternalEntities: NO];
	[goParser parse];
    
}

#pragma mark -
#pragma mark Parser Delegate methods
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@"completed parsing file");
    NSError *saveError = [[NSError alloc]init];
    if (![self.managedObjectContext_ save:&saveError]) {
        //NSLog(@"Error while saving.");
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (![elementName compare:@"item"]) {
        
        NSManagedObject *aStory = [NSEntityDescription insertNewObjectForEntityForName:@"Movies"inManagedObjectContext:self.managedObjectContext_];
        [aStory setValue:self.ititle forKey:@"descriptionn"];
       
        
        return;
    }

    else if(![elementName compare:@"description"])
    {
        NSLog(@"description %@",_current);
        if (_current)
        self.ititle = [[NSString alloc] initWithString:[_current stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
    }
    _current=nil;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!_current)
        _current = [[NSMutableString alloc] initWithString:string];
    else
        [_current appendString:string];
    
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to open file (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
}
@end
