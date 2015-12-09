//

#import "IMImageView.h"
#import "StringUtil.h"
#define IMAGE_PATH @"~/Documents"
#define kPhotosThumbsFolderName @"PhotoThumbs"


@interface IMImageView ()
- (void)continueLoadingImage;
@end

@implementation IMImageView
@synthesize imageURL, delegate;//, issueId;
@synthesize cacheFolderPath;


+ (BOOL)initTemporaryCache {
	NSError *error;
	/* create path to cache directory inside the application's Documents directory */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSMutableString *tempDataPath = [[NSMutableString alloc] init];
    [tempDataPath setString:[[paths objectAtIndex:0] stringByAppendingPathComponent:@"image_TemporaryCache"]];
	
    BOOL status =FALSE;
	/* check for existence of cache directory */
	if ([[NSFileManager defaultManager] fileExistsAtPath:tempDataPath]) {
		status = TRUE;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:tempDataPath 
								   withIntermediateDirectories:NO
													attributes:nil 
														 error:&error]) {

		status = FALSE;
	}
    [tempDataPath release];

	return status;
}

+(NSString *)getTemporaryCache {
    
    [IMImageView initTemporaryCache];
    /* create path to cache directory inside the application's Documents directory */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSMutableString *tempDataPath = [[NSMutableString alloc] init];
    [tempDataPath setString:[[paths objectAtIndex:0] stringByAppendingPathComponent:@"image_TemporaryCache"]];
	
	
        return [tempDataPath autorelease];

}
+(void)clearTemporayCache {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *saveDirectory =[IMImageView getTemporaryCache];
    NSArray *cacheFiles = [fileManager contentsOfDirectoryAtPath:saveDirectory error:&error];
    for (NSString *file in cacheFiles) {
        error = nil;
        [fileManager removeItemAtPath:[saveDirectory stringByAppendingPathComponent:file] error:&error];
        /* handle error */
    }
    
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		activityIndicator = nil;
    }
    return self;
}

- (id)initWithContentsOfURL:(NSURL*)inURL {
	if( self = [super init] ) {
		
		activityIndicator = nil;
		[self createThumbsFolder];

		self.imageURL = inURL;
		downloadQueue = [[NSOperationQueue alloc] init];
		[self continueLoadingImage];
	}
	return self;
}

#pragma mark -
- (void)startLoadinImageWithURL:(NSURL *)inURL 
{	
	self.image = nil;
	
	if (!activityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
            activityIndicator.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
 
        activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin ;
		[self addSubview:activityIndicator];
	}	
	
	[activityIndicator startAnimating];
	self.imageURL = [inURL isKindOfClass:[NSURL class]] ? inURL : [NSURL URLWithString:(NSString *)inURL];
	downloadQueue = [[NSOperationQueue alloc] init];
	[self continueLoadingImage];
}

- (void)continueLoadingImage {
    
	NSString* thumnailsFolderPagth =  [IMImageView getTemporaryCache];;
    
    
	NSString* imagePath = [thumnailsFolderPagth 
                           stringByAppendingPathComponent:[StringUtil getUniqueFilenameFor:self.imageURL]];
	if( [[NSFileManager defaultManager] fileExistsAtPath:imagePath] ) 
	{
		UIImage* newImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
        
		[self setNewImage:newImage];
		[newImage release];
	}
	else {
		NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
											initWithTarget:self
											selector:@selector(loadImage:) 
											object:imagePath];
		[downloadQueue addOperation:operation]; 
		[operation release];
	}
}

- (void)setNewImage:(UIImage*)inImage {
	if (inImage == nil) {
	}
	else {
		self.image =  inImage;
	}
	
	if( delegate && [delegate respondsToSelector:@selector(imageViewDidLoadImage:)] ) {
		[delegate imageViewDidLoadImage:self];
	}
	[activityIndicator stopAnimating];
	[activityIndicator release];
	activityIndicator = nil;
}

- (void)loadImage:(NSString*)imagePath {
	NSData* imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
	UIImage* newImage = [[UIImage alloc] initWithData:imageData];
	
	BOOL success = [imageData writeToFile:imagePath atomically:YES];
	if (success) {
	}
	[self performSelectorOnMainThread:@selector(setNewImage:) withObject:newImage waitUntilDone:NO];
    [newImage release];
    [imageData release];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSString *)documentsFolderPath
{
    return nil;
}

- (void)createThumbsFolder
{
    
}

- (void)dealloc {
	self.imageURL = nil;
	[downloadQueue cancelAllOperations];
	[downloadQueue release];
	downloadQueue = nil;
	self.cacheFolderPath = nil;
    [super dealloc];
}


@end
