//
//  YLazyListViewLayoutMgr.m
//  YArts
//
//  Created by mickey on 15/12/5.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyListViewLayoutMgr.h"
#import "Masonry.h"
@implementation YLazyListViewLayoutMgr
-(void)viewDidMovedWith:(NSInteger)index view:(YLazyListItem *)item
{
    
    CGSize itemSize = self.lazyListView.itemSize;
    NSLog(@"viewDidMovedWith :%ld, %@",(long)index,NSStringFromCGSize(itemSize));
    [item mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(itemSize.width, itemSize.height));
        make.left.mas_equalTo(itemSize.width * index);
        make.top.mas_equalTo(0);
    }];
    //item.frame = CGRectMake( itemSize.width * index, 0, itemSize.width, itemSize.height);
}
@end
