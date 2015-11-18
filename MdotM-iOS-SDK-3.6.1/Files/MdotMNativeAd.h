//
//  NativeAd.h
//  MdotMAdsSDK2
//
//  Created by TechJini on 11/08/15.
//
//

#import <Foundation/Foundation.h>

@interface MdotMNativeAd : NSObject{
    
}


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *callToAction;
@property (nonatomic, copy) NSString *nativeID;

@property (nonatomic, copy)   NSString *clickThroughURL;
@property (nonatomic, strong) NSMutableArray  *clickTrackingArray;
@property (nonatomic, strong) NSMutableArray  *impressionURLArray;

@property (nonatomic, copy)   NSString    *iconURL;
@property (nonatomic, assign) CGSize      iconSize;
@property (nonatomic, copy)   NSString    *coverImageURL;
@property (nonatomic, assign) CGSize      coverImageSize;

@property (nonatomic, strong)   UIImage    *coverImage;
@property (nonatomic, strong)   UIImage    *iconImage;


- (id)initWithDictionary:(NSDictionary *)elementDictionary;
// self.impressionUrlArray
//MdotMAdImage *coverImage = nativeAd.coverImage; // 1200x627
//MdotMAdImage *icon = nativeAd.icon; // 80x80

@end
