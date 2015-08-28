//
//  GravityClient.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityClient.h"

GravityResultOrder const GravityResultOrderPersonalized = @"personalized";
GravityResultOrder const GravityResultOrderRelevance = @"relevance";
GravityResultOrder const GravityResultOrderPopular = @"popular";

@interface GravityClient (){
    NSMutableArray *requests;
    NSMutableArray *events;
    CLLocationManager *locationManager;
    NSMutableDictionary *trackedItems;
}
@end

@implementation GravityClient

- (id)init
{
    self = [super init];
    if (self) {
        requests = [NSMutableArray array];
        events = [NSMutableArray array];
        self.recommendedItems = [NSMutableDictionary dictionary];
        trackedItems = [NSMutableDictionary dictionary];
        self.cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return self;
}

- (id)initWithURL:(NSString *)url{
    self = [self init];
    if (self) {
        self.baseURL = url;
    }
    return self;
}

- (id)initWithURL:(NSString *)url username:(NSString *)username password:(NSString *)password
{
    self = [self init];
    if (self) {
        self.baseURL = url;
        self.username = username;
        self.password = password;
    }
    return self;
}

+ (NSString *) escapeString:(NSString *)aString{
    return [aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (GravityRequest *) sendRequest:(GravityRequest *)request{
    [requests insertObject:request atIndex:0];
    [request send];
    return request;
}

- (GravityRequest *) sayHelloTo:(NSString *)name{
    name = [GravityClient escapeString:name];
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeHello];
    request.method = @"test";
    [request.params addObject:[[GravityNameValue alloc] initWithName:@"name" value:name]];
    return [self sendRequest:request];
}

- (GravityRequest *) recommendItemsForScenario:(NSString *)scenarioId limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues{
    return [self recommendItemsForScenario:scenarioId limit:limit resultNameValues:nameValues attributes:nil];
}

- (GravityRequest *) recommendItemsForScenario:(NSString *)scenarioId limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues attributes:(NSArray *)attributes{
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeRecommendation];
    request.method = @"getItemRecommendation";
    if(self.userId)
        [request.params addObject:[GravityNameValue nameValueWithName:@"userId" value:self.userId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"scenarioId" value:scenarioId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"cookieId" value:self.cookieId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"numberLimit" value:[NSString stringWithFormat:@"%i", limit]]];
    for (NSString *nameValue in nameValues) {
        [request.params addObject:[GravityNameValue nameValueWithName:@"resultNameValue" value:nameValue]];
    }
    for (GravityNameValue *nameValue in attributes) {
        [request.params addObject:nameValue];
    }
    return [self sendRequest:request];
}

- (GravityRequest *) recommendItemsWithContext:(GravityRecommendationContext *)context{
    return [self recommendItemsForScenario:context.scenarioId limit:context.limit resultNameValues:context.resultNameValues attributes:context.nameValues];
}

- (GravityRequest *) recommendItemsWithContexts:(NSArray *)contexts{
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeBulkRecommendation];
    request.method = @"getItemRecommendationBulk";
    if(self.userId)
        [request.params addObject:[GravityNameValue nameValueWithName:@"userId" value:self.userId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"cookieId" value:self.cookieId]];
    
    NSMutableArray *bodyData = [NSMutableArray arrayWithCapacity:contexts.count];
    
    
    
    for(GravityRecommendationContext *context in contexts){
        NSMutableArray *nameValues = [NSMutableArray array];
        for(GravityNameValue *nameValue in context.nameValues){
            [nameValues addObject:[nameValue dictionary]];
        }
            
        NSDictionary *dict = @{
            @"numberLimit": [NSNumber numberWithUnsignedInt:context.limit],
            @"scenarioId": context.scenarioId,
            @"resultNameValues":context.resultNameValues,
            @"nameValues":nameValues
        };
        [bodyData addObject:dict];
    }
    
    request.body = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
    
    return [self sendRequest:request];
}

- (GravityRequest *) searchItemsWithKeyword:(NSString *)keyword limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues{
    return [self searchItemsWithKeyword:keyword limit:limit resultNameValues:nameValues orderBy:GravityResultOrderPersonalized];
}

- (GravityRequest *) searchItemsWithKeyword:(NSString *)keyword limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues orderBy:(GravityResultOrder) order{
    keyword = [GravityClient escapeString:keyword];
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeSearch];
    request.type = GravityRequestTypeRecommendation;
    request.method = @"getItemRecommendation";
    if(self.userId)
        [request.params addObject:[GravityNameValue nameValueWithName:@"userId" value:self.userId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"scenarioId" value:@"LIVESEARCH"]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"q" value:keyword]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"cookieId" value:self.cookieId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"numberLimit" value:[NSString stringWithFormat:@"%i", limit]]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"orderBy" value:order]];
    for (NSString *nameValue in nameValues) {
        [request.params addObject:[GravityNameValue nameValueWithName:@"resultNameValue" value:nameValue]];
    }
    return [self sendRequest:request];
}

- (GravityRequest *) addEvent:(GravityEvent *)event{
    
    /*
     Location
    */
    if(self.location) [event setLocation:self.location];
    
    /*
     RecId tracking
    */
    
    if([event.type isEqualToString:@"REC_CLICK"]){
        event.recommendationId = [self.recommendedItems objectForKey:event.itemId];
        [trackedItems setObject:event.recommendationId forKey:event.itemId];
    }else if([trackedItems objectForKey:event.itemId] != nil){
        event.recommendationId = [trackedItems objectForKey:event.itemId];
    }
    
    
    GravityRequest *request = [[GravityRequest alloc] init];
    request.type = GravityRequestTypeEvent;
    request.method = @"addEvents";
    request.body = [event JSON];
    return [self sendRequest:request];
}

- (GravityRequest *) addEventForItem:(NSString *)itemId type:(NSString *)type{
    GravityEvent *event = [[GravityEvent alloc] init];
    event.userId = self.userId;
    event.cookieId = self.cookieId;
    event.itemId = itemId;
    event.type = type;
    return [self addEvent:event];
}


#pragma mark CLLocationManagerDelegate methods

- (void)trackLocation{
    if(locationManager == nil){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"CoreLocation error");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    [self setLocation:location];
    [locationManager stopUpdatingLocation];
}

@end
