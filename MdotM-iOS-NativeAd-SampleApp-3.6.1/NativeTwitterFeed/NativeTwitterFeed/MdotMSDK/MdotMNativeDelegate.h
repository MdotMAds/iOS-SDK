//
//  MdotMNativeDelegate.h
//  MdotMAdsSDK2
//
//  Created by TechJini on 12/08/15.
//
//

#import <Foundation/Foundation.h>
#import "MdotMNativeAd.h"
@protocol MdotMNativeDelegate <NSObject>

@optional
-(void) onReceiveNativeAd:(NSArray*)nativeAdArray;
-(void) onFailedToReceiveNativeAd:(NSString *)error;
-(void) onReceiveClickInNativeAd;

@end
