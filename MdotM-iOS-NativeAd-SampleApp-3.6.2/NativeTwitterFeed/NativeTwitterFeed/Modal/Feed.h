//
//  Icons.h
//  MdotMAdsSDK2
//
//  Created by TechJini on 23/07/15.
//
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject


@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *feedText;
@property (nonatomic, copy) NSString *profilPic;
@property (nonatomic, copy) NSString *feedURL;

- (id)initWithDictionary:(NSDictionary *)attributesDictionary;

@end
