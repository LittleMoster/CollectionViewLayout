//
//  ViewController.m
//  CollectionViewText
//
//  Created by cguo on 2017/5/23.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ViewController.h"
#import "BoxLayout.h"
#import "MyCollectionViewCell.h"
#import "HeaderReusableView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BoxLayoutDelegate>

@property(nonatomic,strong)UICollectionView *collectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    BoxLayout *layout=[[BoxLayout alloc]init];
    layout.delegate=self;
    
    self.collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) collectionViewLayout:layout];
    self.collectView.delegate=self;
    self.collectView.showsVerticalScrollIndicator=NO;
    self.collectView.alwaysBounceVertical = YES;
    self.collectView.dataSource=self;
    self.collectView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.collectView];
    
    [self.collectView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"MyCollectionCellId"];
    
     [self.collectView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
    [self.collectView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HeaderReusableView"];
}

-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (section==0){
        return 17;
    }if (section==3) {
        return 7;
    }
    return  3;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  4;
}
-(CollectionViewLayoutType)LayoutTypeInSeation:(NSInteger)section
{
  
    if (section==0) {
        return  WaterflowLayout;
    }
    if (section==1) {
        return LayoutTypeTwo;
    }
    if (section==2) {
        return LayoutTypeThree;
    }
    if (section==3) {
          return LayoutTypeOne;
    }
      return WaterflowLayout;
    
   
}

-(CGFloat)waterflowLayout:(CollectionViewLayoutType)flowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    if (waterflowLayout==WaterflowLayout) {
        return (arc4random()%+1)*40;
    }
    return  60;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCellId" forIndexPath:indexPath];
    
       return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind ==UICollectionElementKindSectionHeader) {
        
        HeaderReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
        headerView.label.text=@"header";
        return headerView;
        
    }else
    {
        
        HeaderReusableView *footView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
        footView.label.text=@"foot";
        return footView;
    }
 
}


@end
