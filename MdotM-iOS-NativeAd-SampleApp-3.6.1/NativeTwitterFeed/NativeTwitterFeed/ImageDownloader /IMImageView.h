//

#import <UIKit/UIKit.h>

@protocol IMImageViewDelegate;
@interface IMImageView : UIImageView {
	id<IMImageViewDelegate> delegate;
	NSOperationQueue* downloadQueue;
	NSURL*			imageURL;
//	NSString* issueId;
//	IBOutlet UILabel* issueNumber;
	UIActivityIndicatorView* activityIndicator;
	NSString* cacheFolderPath;
    

}
@property (nonatomic, retain) NSString* cacheFolderPath;
@property(nonatomic, retain)NSURL*					imageURL;
@property(nonatomic, assign)id<IMImageViewDelegate> delegate;

+ (NSString *)getTemporaryCache;
+ (void)clearTemporayCache;
- (void)setNewImage:(UIImage*)inImage;
- (NSString *)documentsFolderPath;
- (void)createThumbsFolder;
- (void)startLoadinImageWithURL:(NSURL *)inURL;
@end

@protocol IMImageViewDelegate <NSObject>
- (void)imageViewDidLoadImage:(IMImageView*)imageView;
@end

