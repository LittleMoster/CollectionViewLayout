//
//  MyCollectionViewCell.m
//  CollectionViewText
//
//  Created by cguo on 2017/5/23.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    self.label.text=@"fjkewhfj";
    self.imageV.image=[UIImage imageNamed:@"ser_zl02"];

}

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    if (self=[super initWithFrame:frame]) {
//        
//        
//    }
//    return self;
//}


@end
