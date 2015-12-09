//
//  GridCell.h
//  IstanbulModern
//
//  Created by swaroopp on 09/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMImageView.h"
@interface GridCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *adLabel;
@property (nonatomic,retain) IBOutlet IMImageView *gridItem2;
@property (nonatomic,retain) IBOutlet UILabel *screenNameLabel;
@property (nonatomic,retain) IBOutlet UILabel *feedTextLabel;

@end
