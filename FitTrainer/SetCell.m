//
//  SetCell.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }    
    return self;
}


- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
}


@end
