//
//  HH3ViewController.m
//  HHTabList
//
//  Created by Dheeraj Kaveti on 6/10/13.
//  Copyright (c) 2013 Houdah Software. All rights reserved.
//

#import "HH3ViewController.h"
#import "HHGoogleParser.h"
#import "HHWebViewController.h"
@interface HH3ViewController ()

@end

@implementation HH3ViewController
@synthesize events,managedObjectContext_,fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fillArrays];
    UIBarButtonItem *chkmanuaaly = [[UIBarButtonItem alloc]initWithTitle:@"Ref" style:UIBarButtonItemStyleBordered target:self action:@selector(nextview)];
    self.navigationItem.rightBarButtonItem=chkmanuaaly;



    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)nextview{
    [self deleteEvents];
    HHGoogleParser *vC =[[HHGoogleParser alloc]init];
    vC.managedObjectContext_=self.managedObjectContext_;
    [vC parsingXml ];
    [self fillArrays];
    [self.tableView reloadData];
}
-(void)deleteEvents{
    
    [self deleteEntity:@"Movies"];
    
}
-(void)deleteEntity:(NSString *)EntityName
{
    NSArray *deleting = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:EntityName inManagedObjectContext:self.managedObjectContext_]];
    [fetchRequest setFetchBatchSize:50];
    
    NSError *error;
    
    deleting = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *ent in deleting) {
        [managedObjectContext_ deleteObject:ent];
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
    return [events count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSManagedObject *mObject = [events objectAtIndex:indexPath.section];

    NSArray* foo =[[mObject valueForKey:@"descriptionn"] componentsSeparatedByString: @","];
    cell.textLabel.text=[[foo objectAtIndex:1]stringByReplacingOccurrencesOfString:@"title:" withString:@""];
    
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
    HHWebViewController *viewController =[HHWebViewController alloc];
    NSManagedObject *mObject = [events objectAtIndex:indexPath.section];
    
    NSArray* foo =[[mObject valueForKey:@"descriptionn"] componentsSeparatedByString: @","];
    viewController.webLink=[[foo objectAtIndex:0]stringByReplacingOccurrencesOfString:@"link:" withString:@""];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void) fillArrays {
    
    events = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init ];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Movies" inManagedObjectContext:managedObjectContext_]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"descriptionn" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSError *error;
    
    self.events = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
    
}
@end
