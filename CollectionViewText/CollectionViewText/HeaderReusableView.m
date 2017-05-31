//
//  HeaderReusableView.m
//  CollectionViewText
//
//  Created by cguo on 2017/5/23.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "HeaderReusableView.h"

@implementation HeaderReusableView


-(instancetype)initWithFrame:(CGRect)frame
{
  self=  [super initWithFrame:frame];
    if (self) {
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        
        [self addSubview:self.label];

    }
    return self;
    }
@end
