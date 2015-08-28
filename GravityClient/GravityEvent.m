//
//  GravityEvent.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityEvent.h"

@implementation GravityEvent

- (id)init
{
    self = [super init];
    if (self) {
        self.time = [NSDate date];
        self.nameValues = [NSMutableArray array];
        
        UIDevice *device = [UIDevice currentDevice];
        NSString *country = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
        [self.nameValues addObject:[GravityNameValue nameValueWithName:@"deviceName" value:[device name]]];
        [self.nameValues addObject:[GravityNameValue nameValueWithName:@"country" value:country]];
    }
    return self;
}

- (NSDictionary *)dictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"eventType"] = self.type;
    dict[@"time"] = [NSNumber numberWithInt:(int)[self.time timeIntervalSince1970]];
    dict[@"itemId"] = self.itemId;
    if(self.userId)
        dict[@"userId"] = self.userId;
    dict[@"cookieId"] = self.cookieId;
    dict[@"recommendationId"] = self.recommendationId;
    NSMutableArray *nameValues = [NSMutableArray array];
    for (GravityNameValue *nameValue in self.nameValues) {
        [nameValues addObject:[nameValue dictionary]];
    }
    dict[@"nameValues"] = nameValues;
    return dict;
}

- (NSData *) JSON{
    NSArray *arr = @[[self dictionary]];
    
    NSLog(@"%i", [NSJSONSerialization isValidJSONObject:arr]);
    return [NSJSONSerialization dataWithJSONObject:arr options:0 error:nil];
}

- (void)setLocation:(CLLocation *)location{
    NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    [self.nameValues addObject:[GravityNameValue nameValueWithName:@"longitude" value:longitude]];
    [self.nameValues addObject:[GravityNameValue nameValueWithName:@"latitude" value:latitude]];
}

@end
