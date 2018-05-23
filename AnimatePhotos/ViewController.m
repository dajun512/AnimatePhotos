//
//  ViewController.m
//  AnimatePhotos
//
//  Created by pro on 2018/5/23.
//  Copyright © 2018年 ChenXiaoJun. All rights reserved.
//



#import "ViewController.h"
#import "PhotoCell.h"
#import "PhotoFlowLayout.h"
#define ScreenW [[UIScreen mainScreen] bounds].size.width

static NSString * const kPhotoCellId = @"kPhotoCellId";

@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //*********创建布局
    PhotoFlowLayout *layout = ({
        PhotoFlowLayout *layout = [[PhotoFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(160, 160);
        layout.minimumLineSpacing = 50;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 100, 0, 100);
        layout;
    });
    
    
    //*********创建CollectionView
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, ScreenW, 200) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor redColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kPhotoCellId];
        collectionView;
    });
    
    //添加CollectionView
    [self.view addSubview:collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellId forIndexPath:indexPath];
    
    UIImage *photo = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.item + 1]];
    
    cell.photoImgView.image = photo;
    return cell;
}


@end
