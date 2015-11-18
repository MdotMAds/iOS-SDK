//
//  MdotMNetworkManagerDelegate.h
//  MdotMiOSSDK2
//
//  Created by MdotM on 27/07/12.
//  Copyright (c) 2012 MdotM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkManagerDelegate <NSObject>

@optional
-(void)onDataReceived:(NSArray*)feedArray;
-(void)onDataFailure:(NSString*)detailString;
@end
