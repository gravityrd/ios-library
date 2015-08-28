//
//  GravityEvent.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "GravityNameValue.h"

/**
 An event that can be sent to a Gravity service
 */
@interface GravityEvent : NSObject

/**
 Id of the event
 */
@property NSNumber *Id;

/**
 Type of event
 */
@property NSString *type;

/**
 The relevant recommendation ID
 It is automatically set after a REC_CLICK event for each recommended items
 */
@property NSString *recommendationId;

/**
 The relevant item ID
 */
@property NSString *itemId;

/**
 The ID of the user
 */
@property NSString *userId;

/**
 The cookie of the user
 */
@property NSString *cookieId;

/**
 The time when the event occured
 */
@property NSDate *time;

/**
 Extra GravityNameValue parameters
 */
@property NSMutableArray *nameValues;

/**
 Returns GravityEvent as a dictionary
 @return a dictionary representing the event
 */
- (NSDictionary *)dictionary;

/**
 Returns GravityEvent as JSON data
 @return the JSON data representing the event
 */
- (NSData *)JSON;

- (void)setLocation:(CLLocation *)location;

@end
