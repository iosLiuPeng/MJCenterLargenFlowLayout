//
//  SubscribeViewCell.m
//  ExtremeVPN
//
//  Created by 黄磊 on 2017/3/10.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *viewContent;   ///< 内容视图

@property (weak, nonatomic) IBOutlet UILabel *lblPeriod;    ///< 时长文字

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;     ///< 价格文字
@property (weak, nonatomic) IBOutlet UILabel *lblPriceUnit;

@property (weak, nonatomic) IBOutlet UILabel *lblDiscount;  ///< 折扣文字
@property (weak, nonatomic) IBOutlet UIView *viewDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lblTips;          ///< 提示信息
@end

@implementation CollectionViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //根据视图高度，调整其中子视图字体大小
    CGFloat height = self.bounds.size.height;
    _lblPeriod.font = [_lblPeriod.font fontWithSize:height / 256.0 * 28];    ///< 时长文字
    _lblPrice.font = [_lblPrice.font fontWithSize:height / 256.0 * 40];     ///< 价格文字
    _lblPriceUnit.font = [_lblPriceUnit.font fontWithSize:height / 256.0 * 20];     ///< 价格单位
    _lblDiscount.font = [_lblDiscount.font fontWithSize:height / 256.0 * 20];  ///< 折扣文字
    _lblTips.font = [_lblTips.font fontWithSize:height / 256.0 * 20];
}

@end
