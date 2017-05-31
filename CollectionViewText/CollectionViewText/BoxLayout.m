//
//  BoxLayout.m
//  CollectionViewText
//
//  Created by cguo on 2017/5/23.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "BoxLayout.h"
#define kBaseLine(a) (CGFloat)a * SCREEN_WIDTH / 375.0

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define COLORA(R,G,B,A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A]
#define COLOR(R,G,B) COLORA(R,G,B,1.0)

/** 边框*/
#define ViewBorder(View,Width,Color)\
\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@interface BoxLayout ()



@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, strong) NSMutableArray *attrsArr;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;
//方法的申明
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;

@end
/** 默认的列数 */
static const NSInteger DefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat DefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat DefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};
@implementation BoxLayout


//初始化
-(void)prepareLayout {
    [super prepareLayout];
    
    //    清空内容高度
    self.contentHeight = 0;
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    self.contentHeight = 0;
    NSMutableArray *attributesArr = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexP];
        [attributesArr addObject:attr];
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArr addObject:attrs];
        }
        UICollectionViewLayoutAttributes *attr1 = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexP];
        [attributesArr addObject:attr1];
    }
    self.attrsArr = [NSMutableArray arrayWithArray:attributesArr];
}
/// contentSize
-(CGSize)collectionViewContentSize {
    CGFloat height;
    if( self.contentHeight==0)
    {
        height=self.contentHeight;

    }else
    {
        height=self.contentHeight;

    }
           return CGSizeMake(self.collectionView.bounds.size.width,height );
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat height = 0;

    if (elementKind == UICollectionElementKindSectionHeader) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionHeaderForIndexPath:)]) {
            height = [_delegate heightOfSectionHeaderForIndexPath:indexPath];
        }
    } else {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionFooterForIndexPath:)]) {
            height = [_delegate heightOfSectionFooterForIndexPath:indexPath];
            
        }
    }
   
     
            layoutAttrs.frame = CGRectMake(0, self.contentHeight, SCREEN_WIDTH, height);
                self.contentHeight += height;
          self.totalHeight=self.contentHeight;
    
   
    
//    self.contentHeight +=self.contentHeight;
    return layoutAttrs;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(LayoutTypeInSeation:)] &&self.delegate!=nil ) {
     CollectionViewLayoutType type= [self.delegate LayoutTypeInSeation:indexPath.section];

      
    switch (type) {
        case LayoutTypeOne:
            [self layoutAttributesForServiceLayout:layoutAttributes indexPath:indexPath];
            break;
        case LayoutTypeTwo:
            [self layoutAttributesForCopyRightlayout:layoutAttributes indexPath:indexPath];
            break;
        case LayoutTypeThree:
            [self layoutAttributesForPatentLayout:layoutAttributes indexPath:indexPath];
            break;
        case LayoutTypeFour:
            [self layoutAttributesForCaseLayout:layoutAttributes indexPath:indexPath];
            break;
            case WaterflowLayout:
            [self layoutAttributesForWaterFlowt:layoutAttributes indexPath:indexPath];
        default:
            break;
    }
    }else
    {
        switch (indexPath.section) {
            case 0:
                [self layoutAttributesForServiceLayout:layoutAttributes indexPath:indexPath];
                break;
            case 1:
                [self layoutAttributesForCopyRightlayout:layoutAttributes indexPath:indexPath];
                break;
            case 2:
                [self layoutAttributesForPatentLayout:layoutAttributes indexPath:indexPath];
                break;
            case 3:
                [self layoutAttributesForCaseLayout:layoutAttributes indexPath:indexPath];
                break;
                case 4:
                [self layoutAttributesForWaterFlowt:layoutAttributes indexPath:indexPath];
            default:
                break;

    }
    }
    return layoutAttributes;
}

//上一下六模式
- (void)layoutAttributesForServiceLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath {
    CGFloat y = self.contentHeight;
    if (indexPath.item == 0) {
        layoutAttributes.frame = CGRectMake(0, y, SCREEN_WIDTH, kBaseLine(85));
        self.contentHeight += kBaseLine(85);
    } else {
        if (indexPath.item > 6) { return; }
        long row = (indexPath.item -1) % 3;
        CGFloat width = SCREEN_WIDTH / 3.0;
        layoutAttributes.frame = CGRectMake(row * width, y, width, kBaseLine(100));
        if (indexPath.item == 3 || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.contentHeight += kBaseLine(100);
        }
    }
}

//左一右二模式
- (void)layoutAttributesForCopyRightlayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath {
    CGFloat y = self.contentHeight;
    CGFloat width = SCREEN_WIDTH / 2.0;
    CGFloat height = kBaseLine(160);
    switch (indexPath.item) {
        case 0:
            layoutAttributes.frame = CGRectMake(0, y, width, height);
            break;
        case 1:
            layoutAttributes.frame = CGRectMake(width, y, width, height / 2.0);
            break;
        case 2:
            layoutAttributes.frame = CGRectMake(width, (height / 2.0) + y, width, height / 2.0);
            break;
        default:
            break;
    }
    if (indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
        self.contentHeight += height;
    }
}

//上一下二模式
- (void)layoutAttributesForPatentLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath {
    CGFloat y = self.contentHeight;
    CGFloat height = 0;
    switch (indexPath.item) {
        case 0:
            layoutAttributes.frame = CGRectMake(0, y, SCREEN_WIDTH, kBaseLine(85));
            height = kBaseLine(85);
            break;
        case 1:
            layoutAttributes.frame = CGRectMake(0, y, SCREEN_WIDTH/2.0, kBaseLine(80));
            height = kBaseLine(80);
            break;
        case 2:
            layoutAttributes.frame = CGRectMake(SCREEN_WIDTH/2.0, y, SCREEN_WIDTH/2.0, kBaseLine(80));
            height = kBaseLine(80);
            break;
        default:
            break;
    }
    if (indexPath.item == 0 || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
        self.contentHeight += height;
    }
}

//左二右一模式
- (void)layoutAttributesForCaseLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath {
    CGFloat y = self.contentHeight;
    switch (indexPath.item) {
        case 0:
            layoutAttributes.frame = CGRectMake(0, y, SCREEN_WIDTH/2.0, kBaseLine(80));
            self.contentHeight += kBaseLine(80);
            break;
        case 1:
            layoutAttributes.frame = CGRectMake(0, y, SCREEN_WIDTH/2.0, kBaseLine(80));
            self.contentHeight += kBaseLine(80);
            break;
        case 2:
            layoutAttributes.frame = CGRectMake(SCREEN_WIDTH/2.0, y - kBaseLine(160), SCREEN_WIDTH/2.0, kBaseLine(160));
            break;
        default:
            break;
    }
}
//瀑布流布局

#pragma mark - 常见数据处理（代理返回数据封装成get方法处理）
//item行距
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout)]) {
        return [self.delegate rowMarginInWaterflowLayout];
    } else {
        return DefaultRowMargin;
    }
}
//item列间距
- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout)]) {
        return [self.delegate columnMarginInWaterflowLayout];
    } else {
        return DefaultColumnMargin;
    }
}
//列数
- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout)]) {
        return [self.delegate columnCountInWaterflowLayout];
        
    } else {
        return DefaultColumnCount;
    }
}
//item边缘距离
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout)]) {
        return [self.delegate edgeInsetsInWaterflowLayout];
    } else {
        return DefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
/** 存放所有列的当前高度 */
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
/** 存放所有cell的布局属性 */
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- ( void)layoutAttributesForWaterFlowt:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath
{
    // 创建布局属性
//    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的frame，取出每列的宽度
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    //取出每列的高度
    CGFloat h = [self.delegate waterflowLayout:WaterflowLayout heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    
    for (NSInteger i = 1; i < self.columnCount; i++) {
      
       
      
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        //        比较取出最短那列
      
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
 
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    //    最短那列的y值
    CGFloat y = minColumnHeight;
   
    if (y != self.edgeInsets.top) {//如果不是第一列就添加行距
        y += self.rowMargin;
       
    }else
    {
        y +=self.totalHeight-self.rowMargin;
     
    }
    layoutAttributes.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度，已有新的item添加到该列，所以要更新该列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(layoutAttributes.frame));
    
    // 记录内容最高的高度，用最高的高度为CollectionView的内容高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
//        self.contentHeight=columnHeight;
    }
//    return attrs;
}




@end
