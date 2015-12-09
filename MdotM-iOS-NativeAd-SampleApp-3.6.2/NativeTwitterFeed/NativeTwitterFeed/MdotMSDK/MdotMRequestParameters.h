//
//  MdotMRequestParameters.h
//  MdotMiOSSDK2
//
//  Created by MdotM on 8/6/12.
//  Copyright (c) 2012 MdotM. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_REFRESH_TIME 30


@interface MdotMRequestParameters : NSObject {
    //these are Additonal parameters
    NSString *appKey;
    NSString *ua;
    int width;
    int height;
    NSString *fmt;
    NSString *deviceid;
    NSString *bandwidth;
    float latitude;
    float longitude;
    
    NSString *machineModel;
    
    //these parameter are from network extra class
    NSString *extraParameter; // Optional
    NSString *gender;          // Optional
    NSString *age;       // Optional
    NSString *partnerkey;     // Required
    NSString *apikey;         // Required
    
    NSString *version;        // Required
    
    NSString *aid;            // Required
    NSString *ate;            // Required
    
    NSString *test;           // Required
    NSInteger vidsupport;
}
//these are Additonal parameters
@property (nonatomic,copy)NSString *appKey;
@property (nonatomic,copy)NSString *ua;
@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic,copy)NSString *fmt;
@property (nonatomic,copy)NSString *deviceid;
@property (nonatomic,copy)NSString *bandwidth;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

@property (nonatomic,copy) NSString *machineModel;

//these parameter are from network xtra class
@property (nonatomic,copy) NSString *extraParameter;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *partnerkey;
@property (nonatomic,copy) NSString *apikey;
@property (nonatomic,copy) NSString *version;
@property (nonatomic,copy) NSString *aid;
@property (nonatomic,copy) NSString *ate;
@property (nonatomic,copy) NSString *test;
@property (nonatomic, assign) NSInteger vidsupport;
@property (nonatomic, assign) NSInteger rewarded;

+ (NSString *) getSysInfoByName:(char *)typeSpecifier;
@end
