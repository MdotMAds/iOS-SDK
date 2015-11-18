//
//  NetworkManager.m
//  NativeTwitterFeed
//
//  Created by TechJini on 20/10/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import "NetworkManager.h"
#import "Feed.h"

@implementation NetworkManager
@synthesize networkDelegate,responseData;

-(void)loadTwitterAds{
    
     request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://ads.mdotm.com/ads/samples/test-twitter.json"]];
     conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error = nil;
    NSString *serverResponse = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSData* data = [serverResponse dataUsingEncoding:NSUnicodeStringEncoding];
//    data = [data subdataWithRange:NSMakeRange(0, [data length] - 1)];

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//    NSLog(@"serverResponse=%@ responseData =%@json=%@ error=%@",serverResponse,responseData, jsonDict,[error localizedDescription]);

    NSArray *array = [jsonDict objectForKey:@"statuses"];
    NSMutableArray *feedsArray = [[NSMutableArray alloc]init];

    for(NSDictionary *dict in array){

        NSDictionary *userDict = [dict objectForKey:@"user"];
        NSString *textString = [dict objectForKey:@"text"];
        
        NSArray *urlArray = [textString componentsSeparatedByString:@"https://"];
        NSString *combinedSTring = nil;
        
        if(urlArray.count>0 && [textString rangeOfString:@"https://"] .location != NSNotFound)
        {
            NSString *urlString = [urlArray objectAtIndex:1];
            combinedSTring= [NSString stringWithFormat:@"https://%@",urlString];
            NSArray *arr = [combinedSTring componentsSeparatedByString:@" "];
            if(arr.count>0){
                combinedSTring= [arr objectAtIndex:0];
            }
        }
        if(![combinedSTring length])
            combinedSTring = [userDict objectForKey:@"url"];
        NSLog(@"url string=%@",combinedSTring);
        NSString *screenname = [userDict objectForKey:@"screen_name"];
        NSString *profilePic = [userDict objectForKey:@"profile_image_url_https"];
        
        Feed *feed = [[Feed alloc]init];
        feed.screenName = screenname;
        feed.feedURL = combinedSTring;
        feed.profilPic = profilePic;
        feed.feedText = textString;
        [feedsArray addObject:feed];
    }
    NSLog(@"feedsArray=%@ count=%ld",feedsArray,feedsArray.count);
    [networkDelegate onDataReceived:feedsArray];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.networkDelegate onDataFailure:@"Unable to fetch data"];
}

@end
