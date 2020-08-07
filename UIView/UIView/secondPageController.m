//
//  page2.m
//  UIView
//
//  Created by myhexin on 2020/7/30.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "secondPageController.h"

@interface secondPageController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation secondPageController

//设置构造函数
-(instancetype) init{
    self=[super init];
    if(self){
        self.tabBarItem.title=@"热点掘金";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化flowlayout
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing=10;
    flowlayout.minimumInteritemSpacing=10;
    flowlayout.itemSize = CGSizeMake((self.view.frame.size.width-10)/2, 300);
    
    //设置布局
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    
    //可以设置事件
    collectionView.delegate=self;     //delegate
    collectionView.dataSource=self;   //datasource
    
    //需要register
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:collectionView];
}
//设置数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
//设置cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    return cell;
}
//通过delegate设置不同id的图片大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item %3 ==0){
        return CGSizeMake(self.view.frame.size.width, 100);
    }else{
        return CGSizeMake((self.view.frame.size.width-10)/2, 300);
    }
}
@end
