//
//  JLCollectionReusableView.m
//  JLCollectionViewEp
//
//  Created by QiYa on 2016/12/8.
//  Copyright © 2016年 QiYa. All rights reserved.
//

#import "JLCollectionReusableView.h"

@implementation JLCollectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}

@end

@implementation JLCollectionFotterView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor darkGrayColor];
        
    }
    return self;
}

@end

@implementation JLDecorationReusableView : UICollectionReusableView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}
@end

