//
//  AddItemViewController.m
//  GravityClientDemoApp
//
//  Created by gravity on 28/07/16.
//  Copyright © 2016 Gravity R&D. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController (){
    GravityClient *gc;
    GravityItemRecommendation *rec;
}
@end

@implementation AddItemViewController

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
    [gc setUserId:@"iPhoneClient"];
}

- (IBAction)addItemButtonTap:(id)sender{
    GravityItem *item = [[GravityItem alloc] init];
    item.Id = @"sampleItem2";
    item.title = @"Sample product 2";
    item.type = @"sampleItemType2";
    item.hidden = false;
    item.nameValues = [[NSMutableArray alloc] initWithObjects:
                       [[GravityNameValue alloc] initWithName:@"description" value:@"This is only a sample product 2."],
                       [[GravityNameValue alloc] initWithName:@"categoryPath" value:@"mainCategory/subCategory"],
                       [[GravityNameValue alloc] initWithName:@"url" value:@"http://example.com/sampleItem2"],
                       [[GravityNameValue alloc] initWithName:@"imageUrl" value:@"http://example.com/sampleItem2Image.jpg"], nil];
    [gc updateItem:item];
}

- (IBAction)addUserButtonTap:(id)sender{
    GravityUser *user = [[GravityUser alloc] init];
    user.userId = @"featestuser1";
    user.hidden = false;
    user.nameValues = [[NSArray alloc] initWithObjects:
                       [[GravityNameValue alloc] initWithName:@"name" value:@"Fea Test"],
                       [[GravityNameValue alloc] initWithName:@"sex" value:@"male"],
                       [[GravityNameValue alloc] initWithName:@"country" value:@"HUN"], nil];
    [gc addUser:user];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark GravityClientDelegate methods

- (void)didReceiveResponse:(NSString *)response forRequest:(GravityRequest *)request{
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server response" message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
}

@end
