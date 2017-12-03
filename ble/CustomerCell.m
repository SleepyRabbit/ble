//
//  CustomerCell.m
//  ble
//
//  Created by 侯恩星 on 2017/12/3.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame {
//    frame.origin.x += 10;
//    frame.origin.y += 10;
//    frame.size.height += 10;
//    frame.size.width += 10;
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
