//
//  ViewController.m
//  mdotmSample
//
//  Created by TechJini on 14/07/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonHMAC.h>

@interface ViewController ()

@property(nonatomic,strong)IBOutlet UILabel *rewardedLabel;
@property(nonatomic,strong)IBOutlet UISwitch *isRewardedSwitch;

@property (nonatomic, strong) MdotMRequestParameters *intRequest;
@property (nonatomic, strong) MdotMInterstitial *interstitialView;

@end

@implementation ViewController
@synthesize scrollview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:192.0/255.0 blue:239.0/255.0 alpha:1.0]];
    [self.scrollview setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:192.0/255.0 blue:239.0/255.0 alpha:1.0]];

    self.rewardedLabel.hidden = YES;
    self.isRewardedSwitch.hidden = YES;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.showAdButton.enabled = NO;
    self.statusLabel.text = @"Initialize Ad";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)createRequest:(id)sender{
    

    self.rewardedLabel.hidden = NO;
    self.isRewardedSwitch.hidden = NO;
    
    self.interstitialView=nil;
    self.intRequest = nil;
    
    if(self.interstitialView==nil){
        self.intRequest = [[MdotMRequestParameters alloc] init];

        
        self.interstitialView = [[MdotMInterstitial alloc]init];
        self.interstitialView.interstitialDelegate = self;
        
        self.intRequest.appKey = @"testapp";
        self.intRequest.test = @"1"; // 1 or video
        
        
    }
    self.statusLabel.text = @"Initialization complete!";

}

-(IBAction)sendRequest:(id)sender{
    
    self.rewardedLabel.hidden = YES;
    self.isRewardedSwitch.hidden = YES;

    self.statusLabel.text = @"Receiving Ad...";
    
    if(self.isRewardedSwitch.isOn){
        //rewarded
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Rewards" message:@"Enter reward item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        av.tag = 7890;
        av.alertViewStyle = UIAlertViewStylePlainTextInput;
        [av textFieldAtIndex:0].delegate = self;
        [av show];
        
    }
    else{
        //To load interstitial ads
        [self.interstitialView loadInterstitialAd:self.intRequest];
    }
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag == 7890){
        if (buttonIndex == 1) {
            NSString *rewardItem = [alertView textFieldAtIndex:0].text;
            if (rewardItem.length) {
                NSLog(@"reward iem: %@",rewardItem);
                //To load rewarded ads
                [self.interstitialView loadRewardedVideo:self.intRequest reward:rewardItem];
            } else {
                NSLog(@"enter reward item; currently no value");
            }
            
        }
        return;
    }
    
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
}

-(IBAction)showAd:(id)sender{
    
    [self.interstitialView showInterstitial:self animated:NO];
    self.statusLabel.text = @"";
    
}



//Delegate methods
-(void) adWillLeaveApplication
{
}
-(void) onReceiveInterstitialAd
{
    NSLog(@"onReceiveInterstitialAd");
    self.showAdButton.enabled = YES;
    self.statusLabel.text = @"Show Ad";
    
        [self performSelectorOnMainThread:@selector(displayAd) withObject:nil waitUntilDone:NO];

    
}

-(void)displayAd{
    // 'self' object should be the active view controller
    [self.interstitialView showInterstitial:self animated:YES];
}


-(void) onReceiveInterstitialAdError:(NSString *)error
{
    NSLog(@"onReceiveInterstitialAdError");
    self.statusLabel.text = @"Failed to cache";

    
}

-(void) onReceiveClickInInterstitialAd
{
    NSLog(@"onReceiveClickInInterstitialAd");
    
    
}
-(void) willShowModalViewController
{
    
}
-(void) didShowModalViewController
{
}
-(void) willDismissModalViewController
{
    NSLog(@"willDismissModalViewController");
    
}
-(void) didDismissModalViewController{
    
}
-(void) willLeaveApplication
{
}

-(void)onRewardedVideoComplete:(BOOL)isSkipped reward:(NSString*)reward
{
    
    if(reward.length){
        NSLog(@"Reward item = %@, skip=%d ",reward,isSkipped);
        
    }
    else{
        NSLog(@"No Reward item , skip=%d ",isSkipped);
        
    }
    NSString *string = [NSString stringWithFormat:@"You got %@ rewards as reward",reward];
    if(isSkipped){
        
        string = [NSString stringWithFormat:@"You lost %@ rewards for skipping the ad",reward];
    }
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Rewards" message:string delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [av show];

}

@end
