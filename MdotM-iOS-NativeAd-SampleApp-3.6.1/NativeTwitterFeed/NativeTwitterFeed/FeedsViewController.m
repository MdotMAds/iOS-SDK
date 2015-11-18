//
//  ViewController.m
//  NativeTwitterFeed
//
//  Created by TechJini on 20/10/15.
//  Copyright (c) 2015 TechJini. All rights reserved.
//

#import "FeedsViewController.h"
#import "IMImageView.h"
#import "GridCell.h"
#import "Feed.h"
#import "NetworkManager.h"
#import "MdotMRequestParameters.h"
#import "MdotMInterstitial.h"
#import <CommonCrypto/CommonHMAC.h>
#import "AppDelegate.h"


@interface FeedsViewController (){
    }
@property (nonatomic, strong) MdotMRequestParameters *intRequest;

@property(nonatomic,strong) NSMutableArray *twitterFeedsArray ;
@property(nonatomic,strong) NSMutableArray *mDotmAdsArray ;
@property(nonatomic,strong) NSMutableArray *combinedArray ;

@property (nonatomic) CGFloat lastContentOffset;
@property(nonatomic,assign) BOOL isRequesting;
@property(nonatomic,assign) int currentPageNum;


@end

@implementation FeedsViewController
@synthesize feedTableView,twitterFeedsArray,combinedArray,mDotmAdsArray;
@synthesize lastContentOffset,activityInd;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appdate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appdate.networkManager.networkDelegate = self;
    
    self.feedTableView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:194.0/255.0  blue:238.0/255.0  alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:194.0/255.0  blue:238.0/255.0  alpha:1.0];

    self.currentPageNum = 0;
    [activityInd startAnimating];
    self.activityInd.center = self.view.center;
    [activityInd setHidesWhenStopped:YES];

    self.isRequesting= NO;
    twitterFeedsArray = [[NSMutableArray alloc]init];
    mDotmAdsArray = [[NSMutableArray alloc]init];
    combinedArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Instance methods

-(void)loadMdotMAds{
    
    self.isRequesting = YES;
    self.intRequest = [[MdotMRequestParameters alloc] init];
    
    self.nativeView = nil;
    self.nativeView = [[MdotMNativeView alloc] init];
    self.intRequest.appKey = [NSString stringWithFormat:@"test:54"];
    self.intRequest.test = @"1";
    self.intRequest.vidsupport = 2;
    
    self.nativeView.nativeDelegate = self;
    [self.nativeView loadNativeAd:self.intRequest];
    
}

#pragma mark
#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/5;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return combinedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    NSString *cellName = @"GridCell";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cellName = @"GridCelliPad";
    }
    GridCell *cell = (GridCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellName owner:nil  options:nil];
        cell = (GridCell*) [nib objectAtIndex:0];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    id fetchedObject = [self.combinedArray objectAtIndex:indexPath.row];
    if([fetchedObject isKindOfClass:[Feed class]]){
        Feed *feed = [self.combinedArray objectAtIndex:indexPath.row];
        [cell.gridItem2 startLoadinImageWithURL:[NSURL URLWithString:feed.profilPic]];
        cell.screenNameLabel.text = feed.screenName;
        cell.feedTextLabel.text = feed.feedText;
        
    }
    else{
        MdotMNativeAd *nativeAd = [self.combinedArray objectAtIndex:indexPath.row];
        cell.screenNameLabel.text = nativeAd.title;
        [cell.gridItem2 setImage:nativeAd.iconImage];
        cell.feedTextLabel.text = nativeAd.body;
        cell.adLabel.hidden = NO;
        [self.nativeView registerView:cell withNativeID:nativeAd.nativeID withViewController:self];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    id fetchedObject = [self.combinedArray objectAtIndex:indexPath.row];
    if([fetchedObject isKindOfClass:[Feed class]]){
        Feed *feed = [self.combinedArray objectAtIndex:indexPath.row];
        NSLog(@"clicked feedurl=%@",feed.feedURL);
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:feed.feedURL ]];
    }


}

#pragma mark - Network Manager delegate methods

-(void)onDataReceived:(NSArray*)feedArray;
{
    [self.twitterFeedsArray removeAllObjects];
    [self.twitterFeedsArray addObjectsFromArray:feedArray];
    [self loadMdotMAds];

}
-(void)onDataFailure:(NSString*)detailString;
{
    NSLog(@"unable to fetch data");
}

#pragma mark - Native Ad delegate methods

- (void) onReceiveNativeAd:(NSArray*)nativeAdArray;
{

    [self.mDotmAdsArray removeAllObjects];
    int r = arc4random() % nativeAdArray.count;// (0 to 2 if value is 3)
    [self.mDotmAdsArray addObject:[nativeAdArray objectAtIndex:r]];
    
    long value = self.twitterFeedsArray.count-4;
    long randomValue = arc4random() % value;
//    NSLog(@"twitter array count=%d randow=%d",self.mDotmAdsArray.count, randomValue);
    NSArray *fedAr = [self.twitterFeedsArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(randomValue, 4)]];

    [self.combinedArray addObjectsFromArray:[fedAr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]]];
    [self.combinedArray addObjectsFromArray:self.mDotmAdsArray];
    [self.combinedArray addObject:[fedAr objectAtIndex:fedAr.count-1]];
    
    [self.feedTableView reloadData];
    [self.feedTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.combinedArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [activityInd stopAnimating];
    
    if(self.currentPageNum>0)
    self.currentPageNum = self.currentPageNum +1;
    self.isRequesting = NO;

}


-(void)onFailedToReceiveNativeAd:(NSString *)error
{
    NSLog(@"onFailedToReceiveNativeAd");
}


-(void)onReceiveClickInNativeAd{
    
    NSLog(@"onReceiveClickInNativeAd");
}


#pragma mark - Scrollview delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    self.currentPageNum = scrollView.contentOffset.y / self.view.frame.size.height;
    NSLog(@"CurrentPage=%d",self.currentPageNum);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Requesting=%d",self.isRequesting);
    
    if (self.lastContentOffset > scrollView.contentOffset.y)
    {
        NSLog(@"Scrolling Up");
    }
    else if (self.lastContentOffset < scrollView.contentOffset.y)
    {
        NSLog(@"Scrolling Down");
        if(!self.isRequesting){
            
            NSLog(@"Next PageNum=%d CombinedArray count/5=%d ",self.currentPageNum+1,self.combinedArray.count/5);
            if(self.currentPageNum+1 == self.combinedArray.count/5){
                //NSLog(@"Load more ads!! self.currentpage=%d self.combinedArray.count=%d",self.currentPageNum,self.combinedArray.count);
                [activityInd startAnimating];
                [self loadMdotMAds];
                
            }
        }
    }
    self.lastContentOffset = scrollView.contentOffset.y;
}


@end
