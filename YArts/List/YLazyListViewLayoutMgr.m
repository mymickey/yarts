//
//  YLazyListViewLayoutMgr.m
//  YArts
//
//  Created by mickey on 15/12/5.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyListViewLayoutMgr.h"
#import "Masonry.h"
#import "NSIndexSet+Util.h"
@interface YLazyListViewLayoutMgr()
{
    NSInteger currentFocusIndex;
    NSInteger currentOrderIndex;
    YLazyListItem *citem;
    YLazyListItem *anchorItem;
    BOOL isInit;
    MASConstraint *m0;
    MASConstraint *m1;
    MASConstraint *m2;
    MASConstraint *m3;
    MASConstraint *m4;
    MASConstraint *m5;
    BOOL isUn;
}
@end
@implementation YLazyListViewLayoutMgr
-(void)viewDidMovedWith:(NSInteger)index view:(YLazyListItem *)item
{
    CGSize itemSize = self.lazyListView.itemSize;
    item.vLeft = itemSize.width * index;
    [item mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(item.superview);
        make.top.mas_equalTo(item.superview);
        make.bottom.mas_equalTo(item.superview);
        make.left.mas_equalTo(item.vLeft);
    }];
        //item.frame = CGRectMake( itemSize.width * index, 0, itemSize.width, itemSize.height);
}
-(void)toLayout:(NSInteger) index
{
    if (!isUn) {
        [m1 uninstall];[m2 uninstall];[m3 uninstall];[m4 uninstall];[m5 uninstall];
    }
    
    isUn = YES;
    CGSize itemSize = self.lazyListView.itemSize;
    NSDictionary *dict = [self getAnchorItem];
    YLazyListItem *targetItem = [dict objectForKey:@"target"];
    YLazyListItem *firstItem = [dict objectForKey:@"first"];
    YLazyListItem *lastItem = [dict objectForKey:@"last"];
    [targetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(itemSize.width * index).priority(2);
    }];
    return;
    [firstItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.right.equalTo(targetItem.mas_left).priority(2);
    }];
    [lastItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.left.equalTo(targetItem.mas_right).priority(2);
    }];

}
-(NSDictionary *)getAnchorItem
{
    NSArray *views = self.lazyListView.itemViews;
    CGFloat contentLeft = self.lazyListView.contentOffset.x;
    YLazyListItem *item;
    YLazyListItem *firstItem;
    YLazyListItem *lastItem;
    YLazyListItem *focusItem;
    NSInteger targetVLeft;
    YLazyListItem *result;
    NSInteger firstVLeft;
    NSInteger lastVLeft;
    
    NSMutableArray *vLefts = [NSMutableArray new];
    for (NSInteger i = 0 ; [views count] > i ; i++) {
        item = [views objectAtIndex:i];
        [vLefts addObject:@(item.vLeft)];
    }
    [vLefts sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *first = [NSNumber numberWithInteger:[obj1 integerValue]];
        NSNumber *second = [NSNumber numberWithInteger:[obj2 integerValue]];
        return [first compare:second];
    }];
    targetVLeft = [[vLefts objectAtIndex:1] integerValue];
    firstVLeft = [[vLefts objectAtIndex:0] integerValue];
    lastVLeft = [[vLefts objectAtIndex:2] integerValue];
    for (NSInteger i=0; [views count] > i; i++) {
        item = [views objectAtIndex:i];
        if (item.vLeft == targetVLeft) {
            result = [views objectAtIndex:i];
        }
        else if (item.vLeft ==  firstVLeft) {
            firstItem = [views objectAtIndex:i];
        }
        else {
            lastItem = [views objectAtIndex:i];
        }
        if (item.vLeft == contentLeft) {
            focusItem = [views objectAtIndex:i];
        }
    }
    return @{
             @"first":firstItem,
             @"last":lastItem,
             @"target":result,
             @"focusItem":focusItem
             };
}


-(void)willRotateLayout
{
    NSDictionary *dict = [self getAnchorItem];
    YLazyListItem *item = [dict objectForKey:@"focusItem"];
    [item.superview bringSubviewToFront:item];
    
}
-(void)rotateLayout
{
    NSArray *views = self.lazyListView.itemViews;

    //return;
    for (NSInteger i = 0; [views count] > i ; i++) {
        [self viewDidMovedWith:((YLazyListItem *)[views objectAtIndex:i]).tag view:[views objectAtIndex:i]];
    }
    [self.lazyListView scrollToItemWithOrderIndex:currentOrderIndex];
    
}
-(void)test
{
    [self.lazyListView scrollToItemWithOrderIndex:currentOrderIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    currentFocusIndex = self.lazyListView.focusIndex;
    currentOrderIndex = self.lazyListView.orderIndex;
//    NSArray *views = self.lazyListView.itemViews;
//    UIView *item = [views objectAtIndex:currentFocusIndex];
//    [item.superview bringSubviewToFront:item];
    NSLog(@"scrollViewDidEndDragging focus: %li order: %ld",(long)currentFocusIndex,(long)currentOrderIndex);
}

@end
