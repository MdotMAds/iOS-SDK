//
//  GridCell.m
//  IstanbulModern
//
//  Created by swaroopp on 09/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GridCell.h"

@implementation GridCell

@synthesize gridItem2,adLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
