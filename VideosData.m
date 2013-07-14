//
//  VideosData.m
//  Shealth
//
//  Created by Dheeraj kaveti on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideosData.h"
#import "VideoDetails.h"
#import "VideoName.h"


@implementation VideosData

@synthesize question,answer,current,current2;
@synthesize parser=goParser,managedObjectContext=managedObjectContext_,neuroid;
-(void)neuroparser:(NSString *)channleName{
    self.channel=channleName;
   NSString *url=[NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/users/%@/uploads?orderby=updated",channleName];
    goParser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
    self.current = [[NSMutableString alloc]init];
    self.current2 = [[NSMutableString alloc]init];
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
    if (![self.managedObjectContext save:&saveError]) {
        //NSLog(@"Error while saving.");
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if(![elementName compare:@"entry"])
    {
        current =[NSMutableString string];
        //annotation=[[MyAnnotation alloc] init];//creating an instance for that object
    }

    else if ([[attributeDict objectForKey:@"rel"]isEqual:@"alternate"])
    {
        if ([attributeDict objectForKey:@"href"]) 
        {
            answer=[attributeDict objectForKey:@"href"];
        
            
            
        }
    }
    else if ([[attributeDict objectForKey:@"height"]isEqual:@"90"])
    {
        if ([[attributeDict objectForKey:@"width"]isEqual:@"120"]){
            self.neuroid=[[NSString alloc] init ];
            neuroid=[attributeDict objectForKey:@"url"];
            
        }
    }
 
    current=nil;
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (![elementName compare:@"entry"]) {
          VideoName *bStory = [NSEntityDescription insertNewObjectForEntityForName:@"VideoName" inManagedObjectContext:managedObjectContext_];
        bStory.channelName=self.channel;
        
        VideoDetails *aStory = [NSEntityDescription insertNewObjectForEntityForName:@"VideoDetails" inManagedObjectContext:managedObjectContext_];
        aStory.title=question;
        aStory.link=answer;
        aStory.image=neuroid;
        [bStory addDetailsrelationshipObject:aStory];
        [aStory setNameRelationship:bStory];
        
        
        return;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    }
    
    else if(![elementName compare:@"title"]) {
        
        self.question =  [[NSString alloc] initWithString:[current stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];        
        NSLog(@"*******************");
        NSLog(@"the title is %@",self.question);
    }
    current=nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!current)
        current = [[NSMutableString alloc] initWithString:string];
    else
        [current appendString:string];
    
}






- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError { 
	NSString * errorString = [NSString stringWithFormat:@"Unable to open file (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString); 
} 

@end

