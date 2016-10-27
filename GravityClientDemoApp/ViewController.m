//
//  ViewController.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    GravityClient *gc;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gc = [[GravityClient alloc] initWithURL:@"https://webshopdemo2-bud.gravityrd-services.com/grrec-webshopdemo2-war/WebshopServlet" username:@"webshopdemo2" password:@"waeLoot2zo"];
    [gc trackLocation];
    [gc setDelegate:self];
    [gc setUserId:@"iPhoneClient"];
    
    /** USER INFO **/
    UIDevice *device = [UIDevice currentDevice];
    NSLog(@"name: %@", [device name]);
    NSLog(@"systemName: %@", [device systemName]);
    NSLog(@"systemVersion: %@", [device systemVersion]);
    NSLog(@"model: %@", [device model]);
    NSLog(@"localizedModel: %@", [device localizedModel]);
    NSLog(@"userInterfaceIdiom: %i", [device userInterfaceIdiom]);
    NSLog(@"identifierForVendor: %@", [[device identifierForVendor] UUIDString]);
    //NSLog(@"uniqueIdentifier: %@", [device uniqueIdentifier]); // DEPRECATED!
    
    NSLog(@"%@", [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]);
    NSLog(@"%@", [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode]);
    
    NSLog(@"Location-longitude: %f", gc.location.coordinate.longitude);
    NSLog(@"Location-latitude: %f", gc.location.coordinate.latitude);
    
}

- (IBAction)helloButtonTap:(id)sender{
    [gc sayHelloTo:self.helloTextField.text];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark GravityClientDelegate methods

- (void)didReceiveResponse:(NSString *)response forRequest:(GravityRequest *)request{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server response" message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [self.helloTextField resignFirstResponder];

}

@end
