//
//  test.m
//  GravityClientDemoApp
//
//  Created by gravity on 03/08/16.
//  Copyright © 2016 Gravity R&D. All rights reserved.
//

#import <Foundation/Foundation.h>
/*

GravityClient *client = [[GravityClient alloc] initWithURL:url username:username password:password];
client.userId = @"testUser1";
client.delegate  = [[GravityClientDelegate alloc] init];

//Add Event
GravityEvent *event = [[GravityEvent alloc] init];
event.itemId = @"sampleItemId1";
event.userId = @"sampleUserId1";
event.type = @"BUY";
event.nameValues = [[NSMutableArray alloc] initWithObjects:
                    [[GravityNameValue alloc] initWithName:@"unitPirce" value:@"199.9"],
                    [[GravityNameValue alloc] initWithName:@"quantity" value:@"1"],
                    [[GravityNameValue alloc] initWithName:@"orderId" value:@"order-0123"], nil];
[client addEvent:event];

//Add or update items
GravityItem *item = [[GravityItem alloc] init];
item.Id = @"sampleItem1";
item.title = @"Sample product 1";
item.hidden = false;
item.nameValues = [[NSMutableArray alloc] initWithObjects:
                   [[GravityNameValue alloc] initWithName:@"description" value:@"This is only a sample product."],
                   [[GravityNameValue alloc] initWithName:@"categoryPath" value:@"mainCategory/subCategory"],
                   [[GravityNameValue alloc] initWithName:@"url" value:@"http://example.com/sampleItem1"],
                   [[GravityNameValue alloc] initWithName:@"imageUrl" value:@"http://example.com/sampleItem1Image.jpg"], nil];
[client addItem:item];

//Delete items (update)
[client updateItem:item];

//Add or update users
GravityUser *user = [[GravityUser alloc] init];
user.userId = @"featestuser1";
user.hidden = false;
user.nameValues = [[NSArray alloc] initWithObjects:
                   [[GravityNameValue alloc] initWithName:@"name" value:@"Fea Test"],
                   [[GravityNameValue alloc] initWithName:@"sex" value:@"male"],
                   [[GravityNameValue alloc] initWithName:@"country" value:@"HUN"], nil];
[client addUser:user];

//Get item recommendation
NSArray *resultNameValues = [[NSArray alloc] initWithObjects:@"imageUrl", @"Url", nil];
[client getItemRecommendations:@"LLLL_18" limit:5 resultNameValues:resultNameValues];

//Get bulk item recommendation
//ScenarioIds from getAllScenarioInfo
GravityRecommendationContext *c1 = [[GravityRecommendationContext alloc] init];
c1.scenarioId = @"LLLL_18";
c1.limit = 2;
c1.nameValues = [[NSArray alloc] initWithObjects: [[GravityNameValue alloc] initWithName:@"categeoryId" value:@"1"], nil];
c1.resultNameValues = [[NSArray alloc] initWithArray:resultNameValues];
GravityRecommendationContext *c2 = [[GravityRecommendationContext alloc] init];
c2.scenarioId = @"KLKLKLK_30";
c2.limit = 2;
c2.nameValues = [[NSArray alloc] initWithObjects: [[GravityNameValue alloc] initWithName:@"categeoryId" value:@"2"], nil];
c2.resultNameValues = [[NSArray alloc] initWithArray:resultNameValues];
GravityRecommendationContext *c3 = [[GravityRecommendationContext alloc] init];
c3.scenarioId = @"NEWWWWW_27";
c3.limit = 2;
c3.nameValues = [[NSArray alloc] initWithObjects: [[GravityNameValue alloc] initWithName:@"categeoryId" value:@"3"], nil];
c3.resultNameValues = [[NSArray alloc] initWithArray:resultNameValues];
GravityRecommendationContext *c4 = [[GravityRecommendationContext alloc] init];
c4.scenarioId = @"LLLLL_39";
c4.limit = 2;
c4.nameValues = [[NSArray alloc] initWithObjects: [[GravityNameValue alloc] initWithName:@"categeoryId" value:@"4"], nil];
c4.resultNameValues = [[NSArray alloc] initWithArray:resultNameValues];
NSArray *bulkItems = [[NSArray alloc] initWithObjects:c1, c2, c3, c4, nil];
[client getItemRecommendationsBulk:bulkItems];

//Search - old code
[client searchItemsWithKeyword:@"a" limit:5 resultNameValues:resultNameValues];

//Scenario information
[client getAllScenarioInfo];*/