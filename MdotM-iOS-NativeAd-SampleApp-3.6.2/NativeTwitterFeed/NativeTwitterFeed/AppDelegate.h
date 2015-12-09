//
//  AppDelegate.h
//  NativeTwitterFeed
//
//  Created by TechJini on 20/10/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NetworkManager *networkManager;

@end

