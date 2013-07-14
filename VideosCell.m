//
//  JyothiImageCell.m
//  JyothiRana
//
//  Created by Dheeraj Kaveti on 3/20/13.
//  Copyright (c) 2013 Dheeraj Kaveti. All rights reserved.
//

#import "VideosCell.h"

@implementation VideosCell
@synthesize nameLabel,ratingImageView;

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
