//
//  IstanbulModernAppDelegate.h
//  IstanbulModern
//
//  Created by swaroopp on 26/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IMLocalizedString(key, comment) \
[StringUtil getTranslationFor:(key)]

struct StringSize {
    int numberOfLine;
    float height;
    float width;
};
typedef struct StringSize StringSize;


@interface StringUtil : NSObject {
    
}


+ (NSString *)removeHTMLTagsFromString:(NSString *)string;
+ (NSString *)serializeString:(NSString *)inputString;

+ (BOOL)isValidObject:(id)object;
+ (BOOL)isValidString:(NSString *)inputString;

+ (NSString *)filterPhoneNumber:(NSString *)originalString;

+(NSString *)getTranslationFor:(NSString *)_text;

+(NSString *)getUniqueFilenameFor:(NSURL *)url ;
@end

