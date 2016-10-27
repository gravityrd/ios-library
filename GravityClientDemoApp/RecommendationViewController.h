//
//  RecommendationViewController.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/12/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityClient.h"
#import "CoreLocation/CoreLocation.h"

@interface RecommendationViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, GravityClientDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)trackButtonTap:(id)sender;
- (IBAction)recommendButtonTap:(id)sender;

@end
