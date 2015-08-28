//
//  GravityRequest.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/11/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityRequest.h"

@interface GravityRequest (){
    GravityClient *client;
}
@end

@implementation GravityRequest

- (id) initWithClient:(GravityClient *)aClient andType:(GravityRequestType)type
{
    self = [super init];
    if (self) {
        client = aClient;
        _type = type;
        _completed = NO;
        _params = [NSMutableArray array];
        _response = [NSMutableData data];
        _itemRecommendations = [NSMutableArray array];
    }
    return self;
}

- (void)setCompletionHandler:(GravityRequestCompletionHandler)completionHandler{
    _completionHandler = completionHandler;
    if(self.isCompleted){
        self.completionHandler(self);
    }
}

- (void) send{
    NSLog(@"--== GRAVITY REQUEST ==--");
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@/%@", client.baseURL, self.method];
    
    //append params
    if([self.params count] > 0){
        [urlString appendString:@"?"];
        for(GravityNameValue *param in self.params){
            [urlString appendFormat:@"%@=%@&", param.name, param.value];
        }
    }
    NSLog(@"URL: %@", urlString);
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //set body
    if(self.body != nil){
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:self.body];
        NSString *strBody = [[NSString alloc] initWithData:self.body encoding:NSUTF8StringEncoding];
#ifdef DEBUG
        NSLog(@"Body: %@", strBody);
#endif
    }
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    self.connection = theConnection;
    [theConnection start];
}

#pragma mark NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"Authentication...");
    [challenge.sender useCredential:[NSURLCredential credentialWithUser: client.username password:client.password persistence:NSURLCredentialPersistenceForSession] forAuthenticationChallenge:challenge];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Network error!");
}

#pragma mark NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"Receiving data...");
    [self.response appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Finished loading request");
    
    _completed = YES;
    
    NSString *str = [[NSString alloc] initWithData:self.response encoding:NSUTF8StringEncoding];
    if([client.delegate respondsToSelector:@selector(didReceiveResponse: forRequest:)]){
        [client.delegate didReceiveResponse:str forRequest:self];
    }
    
    if(self.type == GravityRequestTypeRecommendation){
        GravityItemRecommendation *gir = [[GravityItemRecommendation alloc] initWithJSON:self.response];
        _itemRecommendation = gir;
        
        client.lastRecommandation = gir;
        
        //save recommended items and recommendation ids
        for(NSNumber *item in gir.itemIds){
            [client.recommendedItems setObject:gir.Id forKey:item];
        }
        
        if ([client.delegate respondsToSelector:@selector(didReceiveRecommendation: forRequest:)]) {
            [client.delegate didReceiveRecommendation:gir forRequest:self];
        }
    }
    
    if(self.type == GravityRequestTypeBulkRecommendation){
        NSArray *recommendations = [NSJSONSerialization JSONObjectWithData: self.response options: 0 error: nil];
        
        for(NSDictionary *recommendation in recommendations){
            GravityItemRecommendation *gir = [[GravityItemRecommendation alloc] initWithDictionary:recommendation];
            
            [self.itemRecommendations addObject:gir];
            
            if ([client.delegate respondsToSelector:@selector(didReceiveRecommendation: forRequest:)]) {
                [client.delegate didReceiveRecommendation:gir forRequest:self];
            }
        }
        
    }
    
    if(self.completionHandler)
        self.completionHandler(self);
    
    NSLog(@"--=======================--");
}


@end