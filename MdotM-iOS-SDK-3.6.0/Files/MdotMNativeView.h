//
//  MdotMNativeView.h
//  MdotMAdsSDK2
//
//  Created by TechJini on 12/08/15.
//
//

#import <UIKit/UIKit.h>
#import "MdotMRequestParameters.h"
#import "MdotMNativeDelegate.h"

@interface MdotMNativeView : UIView< UIGestureRecognizerDelegate>  {
    id<MdotMNativeDelegate> nativeDelegate;
    MdotMRequestParameters* requestObject;
}
@property (nonatomic,assign) BOOL isRedirecting;

@property (nonatomic,assign) id<MdotMNativeDelegate> nativeDelegate;
@property (nonatomic, retain) MdotMRequestParameters* requestObject;
@property (nonatomic,assign) BOOL requestingNativeAd;


-(void)registerView:(UIView*)nativeAdView withViewController:(UIViewController*)viewController;
-(void)unregisterView:(UIView*)nativeAdView;
-(BOOL)loadNativeAd:(MdotMRequestParameters *)request;



@end
