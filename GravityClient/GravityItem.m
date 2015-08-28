//
//  GravityItem.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityItem.h"

@implementation GravityItem

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.Id = dict[@"itemId"];
        self.type = dict[@"itemType"];
        self.title = dict[@"title"];
        self.hidden = [dict[@"hidden"] boolValue];
        self.fromDate = [NSDate dateWithTimeIntervalSince1970: [dict[@"fromDate"] intValue]];
        self.toDate = [NSDate dateWithTimeIntervalSince1970: [dict[@"toDate"] intValue]];
        self.nameValues = [NSMutableArray array];
        for (NSDictionary *nameValue in dict[@"nameValues"]) {
            [self.nameValues addObject:[[GravityNameValue alloc] initWithDictionary:nameValue]];
        }
    }
    return self;
}


@end
