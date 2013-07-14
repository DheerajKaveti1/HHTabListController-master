//
//  HHChannelVideosViewController.m
//  HHTabList
//
//  Created by Dheeraj Kaveti on 7/13/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import "HHChannelVideosViewController.h"
#import "VideosCell.h"
#import "VideosData.h"
#import "HHWebViewController.h"

@interface HHChannelVideosViewController ()

@end

@implementation HHChannelVideosViewController
@synthesize channelName,managedObjectContext,videosList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self ReloadVideosData];
    NSLog(@"%@",self.videosList);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)ReloadVideosData
{
    
    self.videosList = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init ];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"VideoDetails" inManagedObjectContext:managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY nameRelationship.channelName like %@",self.channelName ];
    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSError *error;
    
    self.videosList = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [self.videosList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"videoCell";
    VideosCell *cell =nil;
    
    cell = (VideosCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil )
    {
        NSArray *topLevelObjects =[[NSBundle mainBundle]loadNibNamed:@"VideoCell" owner:nil options:nil ];
        for(id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[VideosCell class]])
            {
				cell =  (VideosCell *) currentObject;
				break;
			}
            
        }
    }
        NSManagedObject *mObject = [videosList objectAtIndex:indexPath.section];
    NSLog(@"%@",[mObject valueForKey:@"link"]);
    cell.nameLabel.numberOfLines=3;
    cell.nameLabel.text=[mObject valueForKey:@"title"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[mObject valueForKey:@"image"]] ];
    [cell.ratingImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Smiley.png"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70;
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
    HHWebViewController *web =[[HHWebViewController alloc]init];
    NSManagedObject *mObject = [videosList objectAtIndex:indexPath.section];
    NSLog(@"%@",[mObject valueForKey:@"link"]);
    [web setWebLink:[mObject valueForKey:@"link"]];
    [self.navigationController pushViewController:web animated:YES];
}

@end
