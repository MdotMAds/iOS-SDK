//
//  ViewController.h
//  NativeTwitterFeed
//
//  Created by TechJini on 20/10/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MdotMNativeView.h"
#import "MdotMNativeDelegate.h"

@interface FeedsViewController : UIViewController<MdotMNativeDelegate>

@property(nonatomic,strong)  IBOutlet UITableView *feedTableView;
@property(nonatomic, strong) MdotMNativeView *nativeView;
@property(nonatomic,strong)  IBOutlet UIActivityIndicatorView *activityInd;

@end

