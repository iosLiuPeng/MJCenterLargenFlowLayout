 //
//  MJCenterLargenFlowLayout.m
//  MJCenterLargenFlowLayout
//
//  Created by 刘鹏 on 2018/5/14.
//  Copyright © 2018年 musjoy. All rights reserved.
//

#import "MJCenterLargenFlowLayout.h"

@interface MJCenterLargenFlowLayout ()
@property (nonatomic, assign) CGFloat lastOffsetX;///< 上次滑动结束时，x轴偏移量
@end

@implementation MJCenterLargenFlowLayout
-(void)prepareLayout {
    // 所有个数
    CGFloat totalWidth = self.collectionView.bounds.size.width;
    CGFloat totalHeight = self.collectionView.bounds.size.height;
    
    // 计算itemSize
    CGFloat itemWidth = (totalWidth) / (1 + 0.2 * 2) * 0.9;
    CGFloat itemHeight = itemWidth / 1.45;
    
    // 适配ipad
    if (itemHeight >= totalHeight) {
        itemHeight = totalHeight * 0.9;
        itemWidth = itemHeight * 1.45;
    }
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置左右缩进
    CGFloat inset = (self.collectionView.bounds.size.width - self.itemSize.width) / 2.0;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

// 设置放大动画
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    // 屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0;
    // 刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        // 移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance / self.collectionView.bounds.size.width;
        // 把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        // 设置cell的缩放
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

//  每次都有图片居中
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 不用系统的预计停止位置，改用当前collection的偏移量 + 速度，保证一次只能滑一页
    CGRect current = CGRectMake(self.collectionView.contentOffset.y, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForElementsInRect:current].firstObject;
    CGFloat itemWidth = attr.size.width;
    
    if (velocity.x < -0.2 || velocity.x > 0.2) {
        // 有一定速度时，才重新估算。
        if (velocity.x > 0) {
            // 向左
            proposedContentOffset = CGPointMake(_lastOffsetX + itemWidth, 0);
        } else {
            // 向右
            proposedContentOffset = CGPointMake(_lastOffsetX - itemWidth, 0);
        }
    }

    // 取当前屏幕内显示的cell
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    // 屏幕中线
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2.0;
    CGFloat minDistance = MAXFLOAT;
    // 计算哪个cell的中心点距屏幕中心点最近，然后保留其相差的距离
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat offset = attr.center.x - centerX;
        if (fabs(offset) <= fabs(minDistance)) {
            minDistance = offset;
        }
    }
    // 重新计算偏移值。将屏幕滑动到最近的那个cell位置
    proposedContentOffset.x += minDistance;
    
    // 取整个内容视图内的cell，计算当前居中的视图是第几个（这里用block传出当前选中index的做法欠妥，待改进）
    CGRect contentRect = CGRectMake(0, 0, self.collectionView.contentSize.width, self.collectionView.contentSize.height);
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:contentRect];
    CGFloat offsetCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2.0;//偏移后的中心点
    CGFloat index = 0;
    CGFloat minOffset = MAXFLOAT;
    for (int i = 0; i < arrayAttrs.count; i++) {
        UICollectionViewLayoutAttributes *attr = arrayAttrs[i];
        CGFloat offset = fabs(attr.center.x - offsetCenterX);
        if (offset <= minOffset) {
            minOffset = offset;
            index = i;
        }
    }
    if (_selectBlock) {
        _selectBlock(index);
    }
    
    _lastOffsetX = proposedContentOffset.x;
    return proposedContentOffset;
}

// 是否需要重新计算布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}
@end
