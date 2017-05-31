//
//  BoxLayout.h
//  CollectionViewText
//
//  Created by cguo on 2017/5/23.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LayoutTypeOne,
    LayoutTypeTwo,
    LayoutTypeThree,
    LayoutTypeFour,
    WaterflowLayout
}CollectionViewLayoutType;

@protocol BoxLayoutDelegate <NSObject>
/**
 *  返回item高度
 *
 *  @param waterflowLayout 布局方式
 *  @param index           第几个item
 *  @param itemWidth       item的宽度
 *
 *  @return item的高度
 */
@required
//必须实现的代理方法
- (CGFloat)waterflowLayout:(CollectionViewLayoutType)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional;
/**
 *  用于返回列数(瀑布流布局)
 *  @return  返回列数
 */
- (CGFloat)columnCountInWaterflowLayout;
/**
 *  用于返回列边距(瀑布流布局)
 *  @return 返回列边距
 */
- (CGFloat)columnMarginInWaterflowLayout;
/**
 *  用于返回行边距(瀑布流布局)
 *  @return 返回行边距
 */
- (CGFloat)rowMarginInWaterflowLayout;
/**
 *  用于返回collectionView的上下左右边距(瀑布流布局)
 *  @return  collectionView的上下左右边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout;


/**
 *返回使用哪一种布局的方式
 */
-(CollectionViewLayoutType)LayoutTypeInSeation:(NSInteger)section;

-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;
@end


@interface BoxLayout : UICollectionViewLayout

@property (nonatomic, assign) id<BoxLayoutDelegate>delegate;
@end
