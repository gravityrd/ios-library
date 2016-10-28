//
//  SearchViewController.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/12/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityClient.h"

@interface SearchViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, GravityClientDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end