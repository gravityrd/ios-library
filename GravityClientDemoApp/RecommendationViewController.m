//
//  RecommendationViewController.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/12/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "RecommendationViewController.h"

@interface RecommendationViewController (){
    GravityClient *gc;
    GravityItemRecommendation *rec;
    CLLocationManager *locationManager;
}
@end

@implementation RecommendationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    gc = [[GravityClient alloc] initWithURL:@"https://webshopdemo2-bud.gravityrd-services.com/grrec-webshopdemo2-war/WebshopServlet" username:@"webshopdemo2" password:@"waeLoot2zo"];
    [gc setDelegate:self];
    [gc setUserId: nil]; //we should set nil object, if we do not know the userId
    //[gc setUserId: @"iPhoneUser"];
    locationManager = [[CLLocationManager alloc] init];
}

- (IBAction)trackButtonTap:(id)sender{
    [gc trackLocation];
}

- (IBAction)recommendButtonTap:(id)sender{
    //[gc getItemRecommendations:@"ITEM_CATEGORY_LIST" limit:10 resultNameValues:@[@"title"]];
    [gc getItemRecommendations:@"ITEM_CATEGORY_LIST" limit:20 resultNameValues:@[@"title"] attributes:@[[GravityNameValue nameValueWithName:@"currentItemId" value:@"1000157509"]]];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row tap");
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [gc trackLocation];
    NSLog(@"Accessory Tap");
    NSString *itemId = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSString *userId = [gc userId];
    NSString *cookieId = [gc cookieId];
    GravityEvent *event = [[GravityEvent alloc] init];
    event.itemId = itemId;
    event.userId = userId;
    event.cookieId = cookieId;
    event.type = @"REC_CLICK";
    event.nameValues = [[NSMutableArray alloc] initWithObjects:
                        [[GravityNameValue alloc] initWithName:@"unitPrice" value:@"199.9"],
                        [[GravityNameValue alloc] initWithName:@"quantity" value:@"1"],
                        [[GravityNameValue alloc] initWithName:@"orderId" value:@"order-0123"], nil];
    [gc addEvent:event];
}

#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell here …
    cell.textLabel.text = (rec.itemIds)[indexPath.row];
    cell.detailTextLabel.text = [(rec.items)[indexPath.row] title];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [rec.itemIds count];
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
