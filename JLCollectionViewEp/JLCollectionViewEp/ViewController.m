//
//  ViewController.m
//  JLCollectionViewEp
//
//  Created by QiYa on 2016/12/8.
//  Copyright © 2016年 QiYa. All rights reserved.
//

#import "ViewController.h"
#import "JLCollectionReusableView.h"
#import "JLFlowLayout.h"

static NSString * const kCollectionCellId = @"CollectionCellId";

static NSString * const kCollectionHeaderId = @"CollectionHeaderId";

static NSString * const kCollectionFooterId = @"CollectionFooterId";

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.collectionView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 12;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return arc4random()%2 == 1 ? 5 : 3;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
        return [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kCollectionFooterId forIndexPath:indexPath];
    } else {
        return [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderId forIndexPath:indexPath];
    }
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return ((UICollectionViewFlowLayout *)collectionViewLayout).footerReferenceSize;
    
    //    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 40);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return ((UICollectionViewFlowLayout *)collectionViewLayout).headerReferenceSize;
    //    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 20);
}



//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 10;
//
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 10;
//
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//    
//}

#pragma mark - Getter & Setter
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = ({
            UIView *header = ({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, - 50, [[UIScreen mainScreen] bounds].size.width - 20, 50)];
                view.backgroundColor = [UIColor redColor];
                view;
            });
            
            UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                              collectionViewLayout:[[JLFlowLayout alloc] init]];
            
            collection.backgroundColor = [UIColor clearColor];
            collection.delegate = self;
            collection.dataSource = self;
            collection.contentInset = UIEdgeInsetsMake(50, 10, 0, 10);
            [collection addSubview:header];
            
            [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellId];
            [collection registerClass:[JLCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderId];
            [collection registerClass:[JLCollectionFotterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kCollectionFooterId];
            
            collection;
        });
        
    }
    
    return _collectionView;
    
}

@end
