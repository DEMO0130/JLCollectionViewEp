//
//  JLFlowLayout.m
//  JLCollectionViewEp
//
//  Created by QiYa on 2016/12/8.
//  Copyright © 2016年 QiYa. All rights reserved.
//

#import "JLFlowLayout.h"
#import "JLCollectionReusableView.h"

static NSString * const kDecorationView = @"DecorationView";

static int const kColumn = 4;
static CGFloat kCellPadding = 4.0f;

@interface JLFlowLayout ()
@property (nonatomic, strong) NSDictionary *decorationRects;

@end

@implementation JLFlowLayout
- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(0, kCellPadding, 0, kCellPadding);
        self.headerReferenceSize = (CGSize){0, 40};
        self.footerReferenceSize = (CGSize){0, 20};
        self.minimumInteritemSpacing = kCellPadding;
        self.minimumLineSpacing = kCellPadding;
        
        [self registerClass:[JLDecorationReusableView class] forDecorationViewOfKind:kDecorationView];
        
    }
    
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right) - (kColumn + 1) * kCellPadding) / kColumn;
    
    self.itemSize = (CGSize){itemW, itemW * 1.25};
    
    /*----------计算DecorationView的布局-----------*/
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    int sectionCount = (int)[self.collectionView numberOfSections];
    
    CGFloat y = 0;
    CGFloat availableWidth = self.collectionViewContentSize.width - (self.sectionInset.left + self.sectionInset.right);
    
    int columns = floorf((availableWidth + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing));
    
    for (int section = 0; section < sectionCount; section++) {
        
        y += self.headerReferenceSize.height;
        
        int itemCount = (int)[self.collectionView numberOfItemsInSection:section];
        
        int rows = ceilf(itemCount/(columns * 1.0));
        
        for (int row = 0; row < rows; row++)
        {
            
            CGFloat h = self.itemSize.height;
            
            if (row > 0) {
                h += self.minimumLineSpacing;
            }
            
            dictionary[[NSIndexPath indexPathForItem:row inSection:section]] = [NSValue valueWithCGRect:CGRectMake(0, y, self.collectionViewContentSize.width, h)];
            
            y += h;
            
        }
        
        y += self.footerReferenceSize.height;
    }
    
    self.decorationRects = [NSDictionary dictionaryWithDictionary:dictionary];
    /*----------计算DecorationView的布局-----------*/
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *newArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    [self.decorationRects enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (CGRectIntersectsRect([obj CGRectValue], rect)) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationView withIndexPath:key];
            attributes.frame = [obj CGRectValue];
            attributes.zIndex = -1;
            [newArray addObject:attributes];
        }
    }];
    
    return newArray.copy;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.decorationRects[indexPath]) { return nil; }
    
    return [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationView
                                                                       withIndexPath:indexPath];
    
}

@end
