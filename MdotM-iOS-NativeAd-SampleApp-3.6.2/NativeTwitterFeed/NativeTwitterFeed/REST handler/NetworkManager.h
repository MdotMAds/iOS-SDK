//
//  NetworkManager.h
//  NativeTwitterFeed
//
//  Created by TechJini on 20/10/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManagerDelegate.h"

@interface NetworkManager : NSObject{
    NSMutableData *responseData;
    
    NSURLRequest *request;
    NSURLConnection *conn ;
}
@property (nonatomic,assign) id<NetworkManagerDelegate> networkDelegate;
@property (nonatomic,strong) NSMutableData *responseData;

-(void)loadTwitterAds;
@end
