//
//  PhotoFlowLayout.m
//  AnimatePhotos
//
//  Created by pro on 2018/5/23.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//

#import "PhotoFlowLayout.h"
#define ScreenW [[UIScreen mainScreen] bounds].size.width
@implementation PhotoFlowLayout


///**
// 每次加载就调用
// */
//- (void)prepareLayout
//{
//    [super prepareLayout];
//
//    NSLog(@"%s",__func__);
//
//}


/**
 返回所有item的属性

 @param rect 确定要获取的范围,如果无限大则一次将collectionView中的item全部返回.默认范围可见范围的item
 @return item的属性集合
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];

    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - (ScreenW * 0.5));
        
        CGFloat scale = 1 - delta / (ScreenW * 0.5) * 0.25;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }

    
    return attrs;
}


/**
 滚动时是否刷新布局
 作用:当返回yes时,只要bounds改变就实时刷新布局
 @param newBounds newBounds
 @return 返回值
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 返回item大小
 时间:刷新或载入item时调用
 @return size
 */
//-(CGSize)collectionViewContentSize
//{
//    NSLog(@"%s",__func__);
//    return [super collectionViewContentSize];
//}


/**
 确定最终滚动偏移点,会自动滚动到指定偏移点
 时间:当手指一松开时马上调用
 @param proposedContentOffset 手指松开时的偏移量
 @param velocity 手指松开时的偏移量
 @return 最终要定位的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //先继承一下
    CGPoint targetPoint = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    //确定最终偏移量的显示大小
    CGRect targetRect = CGRectMake(targetPoint.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    //获取targetRect区域内的所有attrs
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    CGFloat minF = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat delta = (attr.center.x - targetRect.origin.x) - (ScreenW * 0.5);
        if (fabs(delta) < fabs(minF)) {
            minF = delta;
        }
    }
    
    targetPoint.x += minF;
    
    if (targetPoint.x < 0) {
        targetPoint.x = 0;
    }
    
    return targetPoint;
}



@end
