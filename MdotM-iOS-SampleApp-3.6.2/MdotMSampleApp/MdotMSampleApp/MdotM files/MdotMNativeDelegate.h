//
//  MdotMNativeDelegate.h
//  MdotMAdsSDK2
//
//  Created by TechJini on 12/08/15.
//
//

//#ifndef MdotMAdsSDK2_MdotMNativeDelegate_h
//#define MdotMAdsSDK2_MdotMNativeDelegate_h
//
//
//#endif
#import <Foundation/Foundation.h>
#import "MdotMNativeAd.h"
@protocol MdotMNativeDelegate <NSObject>

@optional
-(void) onReceiveNativeAd:(NSArray*)nativeAd;
-(void) onFailedToReceiveNativeAd:(NSString *)error;
-(void) onReceiveClickInNativeAd;

@end
