//
//  MJCenterLargenFlowLayout.h
//  MJCenterLargenFlowLayout
//
//  Created by 刘鹏 on 2018/5/14.
//  Copyright © 2018年 musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJCenterLargenFlowLayout : UICollectionViewFlowLayout
// 滑动到居中的cell的序号回调
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@end
