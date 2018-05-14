//
//  ViewController.m
//  MJCenterLargenFlowLayout
//
//  Created by 刘鹏 on 2018/5/14.
//  Copyright © 2018年 musjoy. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "MJCenterLargenFlowLayout.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectCell:0];
    
    // 滑动居中回调
    MJCenterLargenFlowLayout *flowLayout = (MJCenterLargenFlowLayout *)_collectionView.collectionViewLayout;
    __weak typeof(self) weakSelf = self;
    flowLayout.selectBlock = ^(NSInteger index) {
        [weakSelf selectCell:index];
    };
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [_collectionView reloadData];
}

- (void)selectCell:(NSInteger)index
{
    [_button setTitle:[NSString stringWithFormat:@"第%ld个cell", index + 1] forState:UIControlStateNormal];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中cell：%ld", indexPath.row);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.imgBg.image = [UIImage imageNamed:@"color_blue"];
            break;
        case 1:
            cell.imgBg.image = [UIImage imageNamed:@"color_purple"];
            break;
        case 2:
            cell.imgBg.image = [UIImage imageNamed:@"color_orange"];
            break;
        default:
            break;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
