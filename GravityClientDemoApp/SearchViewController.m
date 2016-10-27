//
//  SearchViewController.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/12/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController (){
    GravityClient *gc;
    GravityItemRecommendation *rec;
    NSTimer *timer;
}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    gc = [[GravityClient alloc] initWithURL:@"https://webshopdemo2-bud.gravityrd-services.com/grrec-webshopdemo2-war/WebshopServlet" username:@"webshopdemo2" password:@"waeLoot2zo"];
    [gc setDelegate:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [rec.itemIds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [(rec.items)[indexPath.row] title];
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - SearchBar delegate

- (void)timerFireMethod:(NSTimer*)theTimer{
    NSLog(@"Timerr %@", theTimer.userInfo);
    [gc searchItemsWithKeyword:theTimer.userInfo limit:10 resultNameValues:@[@"title"]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"search: %@", searchText);
    [timer invalidate];
    timer = [NSTimer timerWithTimeInterval:0.9 target:self selector:@selector(timerFireMethod:) userInfo:searchText repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

#pragma mark GravityClientDelegate methods

- (void)didReceiveResponse:(NSString *)response forRequest:(GravityRequest *)request{
    NSLog(@"resp: %@", response);
}

- (void)didReceiveRecommendation:(GravityItemRecommendation *)recommendation forRequest:(GravityRequest *)request{
    NSLog(@"delegate method!");
    rec = recommendation;
    [self.tableView reloadData];
}

@end
