//
//  AddItemViewController.h
//  GravityClientDemoApp
//
//  Created by gravity on 28/07/16.
//  Copyright © 2016 Gravity R&D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityClient.h"

@interface AddItemViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, GravityClientDelegate, NSLayoutManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addItemButtonTap:(id)sender;
- (IBAction)addUserButtonTap:(id)sender;

@end