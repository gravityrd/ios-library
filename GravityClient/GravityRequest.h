//
//  GravityRequest.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/11/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravityClient.h"
#import "GravityItemRecommendation.h"

@class GravityClient;
@class GravityRequest;

enum {
    GravityRequestTypeHello = 0,
    GravityRequestTypeRecommendation,
    GravityRequestTypeBulkRecommendation,
    GravityRequestTypeSearch,
    GravityRequestTypeEvent
};
typedef NSUInteger GravityRequestType;

typedef void (^GravityRequestCompletionHandler)(GravityRequest *);

/**
 A request to the Gravity service
 */
@interface GravityRequest : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/**
 Type of the request
 */
@property GravityRequestType type;

/**
 The called method
 */
@property NSString *method;

/**
 URL parameters of the request
 */
@property NSMutableArray *params;

/**
 Body of the request
 */
@property NSData *body;

/**
 The relevant connection object
 */
@property NSURLConnection *connection;

/**
 Response of the server
 */
@property NSMutableData *response;

/**
 The request is completed or not
 */
@property (readonly, getter = isCompleted) BOOL completed;

/**
 The received recommendation
 */
@property (readonly) GravityItemRecommendation *itemRecommendation;
@property (readonly) NSMutableArray *itemRecommendations;

/**
 Completion handler of the request
 */
@property (nonatomic, copy) GravityRequestCompletionHandler completionHandler;

- (id) initWithClient:(GravityClient *)client andType:(GravityRequestType)type;
- (void) send;


@end
