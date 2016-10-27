//
//  ViewController.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityClient.h"

@interface ViewController : UIViewController <GravityClientDelegate>

@property (weak, nonatomic) IBOutlet UITextField *helloTextField;
@property (weak, nonatomic) IBOutlet UIButton *helloButton;

- (IBAction)helloButtonTap:(id)sender;

@end
