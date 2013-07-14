//
//  HH1ViewController.m
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import "HH1ViewController.h"
#import "HHChannelVideosViewController.h"
@interface HH1ViewController ()

@end

@implementation HH1ViewController
@synthesize videoImageList,videoNamesList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.videoNamesList=[NSArray arrayWithObjects:@"TV9",@"Sakshi",@"NTV",@"MaaTv",@"MaaMusic",@"ZeeTelugu",@"TeluguFilmNagar",@"Teluguone",@"Shemoroo",@"Volga",@"Mango",@"idleBrain" ,nil];
        self.videoChannelList=[NSArray arrayWithObjects:@"tv9telugu",@"sakshitvcom1",@"ntvtelugunewschannel",@"maatv",@"maamusic",@"zeetvtelugu",@"telugufilmnagar",@"teluguone",@"shemarootelugu",@"newvolgavideo",@"mangoVideos",@"ibvideos2",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![self updateEvents]) {
        [self deleteEvents];
        for (NSString *titles in self.videoChannelList) {
            VideosData *vid =[[VideosData alloc]init];
            vid.managedObjectContext =self.managedObjectContext_;
            [vid neuroparser:titles];
            NSLog(@"%@",titles);
        }
    }
  

   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return  [self.videoNamesList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[self.videoNamesList objectAtIndex:indexPath.section];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string =[self.videoChannelList objectAtIndex:indexPath.section];
    HHChannelVideosViewController *vid =[[HHChannelVideosViewController alloc]init];
    [vid setChannelName:string];
    vid.managedObjectContext=self.managedObjectContext_;
    [self.navigationController pushViewController:vid animated:YES];
    

}

-(void)deleteEvents{
    [self deleteEntity:@"VideoDetails"];
    [self deleteEntity:@"VideoName"];
    
    
}
-(void)deleteEntity:(NSString *)EntityName
{
    NSArray *deleting = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:EntityName inManagedObjectContext:self.managedObjectContext_]];
    
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    //    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [fetchRequest setFetchBatchSize:50];
    
    NSError *error;
    
    
    
    deleting = [self.managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *ent in deleting) {
        [self.managedObjectContext_ deleteObject:ent];
    }
}


-(BOOL)updateEvents{
    NSArray *updateArray = [[NSArray alloc] init];
    
    // create fetched result controller and get result of matching sportids
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"LastUpdated" inManagedObjectContext:self.managedObjectContext_]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastupdated" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [fetchRequest setFetchBatchSize:10];
    
    NSError *error;
    
    updateArray = [self.managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    NSDate *now = [[NSDate alloc] init];
    
    if ([updateArray count] < 1)
    {
        NSManagedObject *anUpdate = [NSEntityDescription insertNewObjectForEntityForName:@"LastUpdated" inManagedObjectContext:self.managedObjectContext_];
        [anUpdate setValue:now forKey:@"lastupdated"];
        NSError *saveError = [[NSError alloc]init];
        if (![self.managedObjectContext_ save:&saveError]) {
            NSLog(@"Error while saving.");
        }
        return NO;
    }
    else if([updateArray count] == 1)
    {
        NSDate *then = [[NSDate alloc] init];
        NSManagedObject *anUpdate = [updateArray objectAtIndex:0];
        then = [anUpdate valueForKey:@"lastupdated"];
        // add update interval to the last update (6 hours, 21600 seconds)
        NSDate *thenPlusSixHours = [[NSDate alloc] initWithTimeInterval:10 sinceDate:then];
        // check if now is later then the last update + interval
        if ([now compare:thenPlusSixHours] == NSOrderedDescending)
        {
            //set new update
            [anUpdate setValue:now forKey:@"lastupdated"];
            NSError *saveError = [[NSError alloc]init];
            if (![self.managedObjectContext_ save:&saveError])
            {
                NSLog(@"Error while saving.");
            }
            return YES;
        }
        
        else
        {
            return NO;
        }
    }
    else {
        //Should not reach open for testing
        return YES;
    }
}


@end
