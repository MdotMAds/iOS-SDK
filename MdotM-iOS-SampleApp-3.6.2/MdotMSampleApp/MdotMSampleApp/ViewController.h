//
//  ViewController.h
//  mdotmSample
//
//  Created by TechJini on 14/07/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MdotMRequestParameters.h"
#import "MdotMInterstitial.h"

@interface ViewController : UIViewController <MdotMInterstitialDelegate,UIAlertViewDelegate>

@property(nonatomic, strong) IBOutlet UIScrollView *scrollview;
@property(nonatomic, strong) IBOutlet UIButton *showAdButton;
@property(nonatomic, strong) IBOutlet UILabel *statusLabel;

-(IBAction)createRequest:(id)sender;
-(IBAction)sendRequest:(id)sender;
-(IBAction)showAd:(id)sender;


@end

