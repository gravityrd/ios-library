//
//  GravityClient.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "GravityRequest.h"
#import "GravityNameValue.h"
#import "GravityEvent.h"
#import "GravityItemRecommendation.h"
#import "GravityRecommendationContext.h"

@class GravityRequest;


typedef NSString* GravityResultOrder;
FOUNDATION_EXPORT GravityResultOrder const GravityResultOrderPersonalized;
FOUNDATION_EXPORT GravityResultOrder const GravityResultOrderRelevance;
FOUNDATION_EXPORT GravityResultOrder const GravityResultOrderPopular;


/**
 Protocol for the delegate of a GravityClient object 
 */
@protocol GravityClientDelegate <NSObject>

@optional
/**
 Called when an error is occured during the connection
 @param error the error object
 @param request the relevant request object
 */
- (void)didReceiveError:(NSString *)error forRequest:(GravityRequest *)request;

/**
 Called when response is received for a request
 @param response the response
 @param request the relevant request object
 */
- (void)didReceiveResponse:(NSString *)response forRequest:(GravityRequest *)request;

/**
 Called when recommendation is received for a request
 @param recommendation the recommendation
 @param request the relevant request object
 */
- (void)didReceiveRecommendation:(GravityItemRecommendation *)recommendation forRequest:(GravityRequest *)request;

@end

/**
 A client for the Gravity recommendation service
 */
@interface GravityClient : NSObject <CLLocationManagerDelegate>

/**
 Delegate of GravityClient
 */
@property id<GravityClientDelegate> delegate;

/**
 Base URL of the REST service
 */
@property NSString *baseURL;

/**
 Username to access the service
 */
@property NSString *username;

/**
 Password of the given username
 */
@property NSString *password;

/**
 UserId of the authenticated client
 This will be automatically included in the request parameters
 */
@property NSString *userId;

/**
 CookieId of the client
 This is automatically generated and unique for every device
 This will be automatically included in the request parameters
 */
@property NSString *cookieId;

/**
 Location of the client
 This will be automatically included in the events sent to the server
 */
@property CLLocation *location;

/**
 The last recommendation received by the client
 */
@property GravityItemRecommendation *lastRecommandation;

/**
 List of items that have already been recommended
 */
@property NSMutableDictionary *recommendedItems;

/**
 Escapes an URL string with percent signes
 @param aString the string to be escaped
 @return the escaped string
 */
+ (NSString *) escapeString:(NSString *)aString;

/**
 Initalizes a GravityClient connection with an URL
 @param url the url of the service
 @return an initializes GravityClient object
 */
- (id)initWithURL:(NSString *)url;

/**
 Initalizes a GravityClient connection with an URL and credentials
 @param url the url of the service
 @param username username to access the service
 @param password the password of the username
 @return an initializes GravityClient object
 */
- (id)initWithURL:(NSString *)url username:(NSString *)username password:(NSString *)password;

/**
 Calls a test REST API call which says hello to the given name
 @param name the name to say hello to
 @return a reference the the request object
 */
- (GravityRequest *) sayHelloTo:(NSString *)name;

/**
 Gets item recommendations
 @param scenarioId the scenario
 @param limit the maximum number of result items
 @param nameValues NameValues that should be included in the result
 @return a reference the the request object
 */
- (GravityRequest *) recommendItemsForScenario:(NSString *)scenarioId limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues;

/**
 Gets item recommendation
 @param scenarioId the scenario
 @param limit the maximum number of result items
 @param nameValues NameValues that should be included in the result
 @param attributes any additional parameter to the request
 @return a reference the the request object
 */
- (GravityRequest *) recommendItemsForScenario:(NSString *)scenarioId limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues attributes:(NSArray *)attributes;

- (GravityRequest *) recommendItemsWithContext:(GravityRecommendationContext *)context;

- (GravityRequest *) recommendItemsWithContexts:(NSArray *)contexts;

/**
 Searches items with the given keyword
 @param keyword keyword to search for
 @param limit the maximum number of result items
 @param nameValues NameValues that should be included in the result
 @return a reference the the request object
 */
- (GravityRequest *) searchItemsWithKeyword:(NSString *)keyword limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues;

/**
 Searches items with the given keyword and orders result
 @param keyword keyword to search for
 @param limit the maximum number of result items
 @param nameValues NameValues that should be included in the result
 @param order defines how to order results
 @return a reference the the request object
 */
- (GravityRequest *) searchItemsWithKeyword:(NSString *)keyword limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues orderBy:(GravityResultOrder) order;

/**
 Adds a new user event
 @param event the event object
 @return a reference the the request object
 */
- (GravityRequest *) addEvent:(GravityEvent *)event;

/**
 Adds a new user event
 @param itemId the itemId related to the event
 @param type type of the event
 @return a reference the the request object
 */
- (GravityRequest *) addEventForItem:(NSString *)itemId type:(NSString *)type;

/**
 Gets user location info and stores it for later events
 */
- (void)trackLocation;

@end
