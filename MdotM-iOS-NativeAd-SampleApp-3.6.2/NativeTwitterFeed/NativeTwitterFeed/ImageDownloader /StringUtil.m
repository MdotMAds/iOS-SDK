//
//  StringUtil.m

#import "StringUtil.h"


@implementation StringUtil

/*!
 
 */

#pragma mark Remove HTML Tags from String 

+ (NSString *)removeHTMLTagsFromString:(NSString *)string {
    
    NSScanner *theScanner;
    NSString  *text = nil;
    
    theScanner = [NSScanner scannerWithString:string];
	
    // Remove HTML Tags from the String 
    while ([theScanner isAtEnd] == NO) {
    
        /* Find start of tag  */
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        /* Find end of tag  */
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // Replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
												   withString:@""];
    } 

	text = nil;
	theScanner = nil;
    
	// Remove HTML special character from string
	theScanner = [NSScanner scannerWithString:string];

	while ([theScanner isAtEnd] == NO) {
		
		/*find start of tag */
		[theScanner scanUpToString:@"&" intoString:NULL] ; 
		
		/* find end of tag */
		[theScanner scanUpToString:@";" intoString:&text] ;
		
		string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;", text]
												   withString:@" "];
	} 
    
    text = nil;
	theScanner = nil;
    
    return string;
}


/*!
 
 */

#pragma mark Serialize String

+ (NSString *)serializeString:(NSString *)inputString
{
	NSMutableString *theMutableCopy = [[inputString mutableCopy] autorelease];
	[theMutableCopy replaceOccurrencesOfString:@"\\" withString:@"\\\\" options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"/"  withString:@"\\/"  options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"\b" withString:@"\\b"  options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"\f" withString:@"\\f"  options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"\n" withString:@"\\n"  options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"\r" withString:@"\\r"  options:0 range:NSMakeRange(0, [theMutableCopy length])];
	[theMutableCopy replaceOccurrencesOfString:@"\t" withString:@"\\t"  options:0 range:NSMakeRange(0, [theMutableCopy length])];
	return theMutableCopy;
}

+(NSString *)getUniqueFilenameFor:(NSURL *)url {
    
    NSMutableString *pathString =[[NSMutableString alloc]  init];
    
    NSArray *pathCompnets =url.pathComponents;
    for (int i =1; i<pathCompnets.count;i++) {
        NSString *path = [pathCompnets objectAtIndex:i];
        [pathString appendFormat:@"_%@",path];

    }
//    DLog(@"%@",pathString);
    
    return [pathString autorelease];
}

/*!
 
 */


#pragma mark Validate Object
+ (BOOL)isValidObject:(id)object {
    
    BOOL validObject = YES;
    if ( (object == nil) || ([object isKindOfClass:[NSNull class]])) {
        
        validObject = NO;
    }
    
    return validObject;
}


#pragma mark Validate String

+ (BOOL)isValidString:(NSString *)inputString {
    
    BOOL valid = YES;
    
    if ( (inputString == nil)
        || ([inputString length] == 0)
        || ([inputString isKindOfClass:[NSNull class]])) {
        
        valid = NO;
    }
    
    return valid;
}


#pragma mark Fileter Phone Number

+ (NSString *)filterPhoneNumber:(NSString *)originalString{
	
	NSMutableString *strippedString = [NSMutableString 
									   stringWithCapacity:originalString.length];
	
	NSScanner *scanner = [NSScanner scannerWithString:originalString];
	NSCharacterSet *numbers = [NSCharacterSet 
							   characterSetWithCharactersInString:@"0123456789,"];
	
	while ([scanner isAtEnd] == NO) {
		NSString *buffer;
		if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
			[strippedString appendString:buffer];
			
		} else {
			[scanner setScanLocation:([scanner scanLocation] + 1)];
		}
	}

	return strippedString;	
}


+(NSString *)getTranslationFor:(NSString *)_text{
    
    NSString *langugaeString =[[NSUserDefaults standardUserDefaults] objectForKey:@"app_language"];
    
    NSString *path= [[NSBundle mainBundle] pathForResource:langugaeString ofType:@"lproj"];  
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    NSString* str=[languageBundle localizedStringForKey:_text value:@"" table:nil];
    if (str==nil) {
        str=_text;
    }
    return str;
    
}


@end
