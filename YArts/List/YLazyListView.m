//
//  YLazyListView.m
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyListView.h"
#import "NSIndexSet+Util.h"
#import "NSArray+slice.h"
@interface YLazyListView()
{
    NSIndexSet *currentIndexs;
    CGFloat beforeX;
    NSInteger beforeIndex;
    BOOL isForceRender;
    UIView *firstView;
}
@end
@implementation YLazyListView
@synthesize itemViews = _itemViews;
@synthesize itemSize = _itemSize;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setFirstView];
    return self;
}
-(void)setFirstView
{
    for (NSInteger i=0; [self.subviews count] > i; i++) {
        if ([self.subviews objectAtIndex:i].tag == 1109) {
            firstView = [self.subviews objectAtIndex:i];
        }
    }
    
}
-(void)syncViewContentSize
{
    CGSize itemSize = self.itemSize;
    self.contentSize = CGSizeMake(self.itemTotal * itemSize.width, itemSize.height);
}
-(CGSize)itemSize
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    //if (CGSizeEqualToSize(_itemSize,CGSizeZero) || !CGSizeEqualToSize(size, _itemSize)) {
        _itemSize = CGSizeMake(size.width, size.height);
        return _itemSize;
    //}
    //return _itemSize;
}
-(NSInteger)focusIndex
{
    
    NSInteger result;
    if (!currentIndexs) {
        result = 0;
    }
    else{
        CGFloat x = self.contentOffset.x;
        CGFloat itemWidth = self.itemSize.width;
        NSInteger index = x / itemWidth;
        NSArray *arr = [currentIndexs toArray];
        result = [arr indexOfObject:@(index)];
    }
    return result;
}
-(NSInteger)orderIndex
{
    CGFloat x = self.contentOffset.x;
    CGFloat itemWidth = self.itemSize.width;
    NSInteger index ;
    if (x < 0) {
        x = 0;
    }
    
    if (beforeX < x) {
        index = ceil( x / itemWidth);
    }else{
        index = floor(x / itemWidth);
    }
    beforeX = x ;
    beforeIndex = index;
    return index;
}
-(NSMutableArray *)itemViews
{
    if (!_itemViews) {
        _itemViews = [NSMutableArray new];
    };
    return _itemViews;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self syncViewContentSize];
}
-(void)syncViewForIndex:(NSInteger) index
{
    [self renderIndexs:index];
}
-(void)renderIndexs:(NSInteger)index
{
    NSIndexSet *newIndexs = [self generateRenderIndexs:index];
    if (currentIndexs && [newIndexs containsIndexes:currentIndexs]) {
        return;
    }
    NSIndexSet *moveIndexs = [NSIndexSet diffIndexs:currentIndexs otherIndexs:newIndexs];//要被移动的位置
    NSIndexSet *destIndexs = [NSIndexSet diffIndexs:newIndexs otherIndexs:currentIndexs];//要移动到的位置
    NSMutableArray *moveViews = [NSMutableArray new];
    [moveIndexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *v = [self findViewByIndex:idx];
        [moveViews addObject:v];
    }];
    if ([moveIndexs count] == 0 && [self.itemViews  count] == 0) {
        [newIndexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            YLazyListItem * v = [self.lazyDelegate listView:self viewForIndex:idx ];
            [moveViews addObject:v];
        }];
    }
    [destIndexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        YLazyListItem *v = [moveViews lastObject];
        [self addItem:v forIndex:idx];
        [moveViews removeLastObject];
    }];
    currentIndexs = newIndexs;
}
-(NSIndexSet *)generateRenderIndexs:(NSInteger)index
{
    NSIndexSet *indexs = currentIndexs;
    if (!indexs) {
        indexs = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(self.orderIndex, self.lazyItemCount)];
    }
    return [indexs primeIndex:index];
    
}

-(void)reload
{
    //[self syncViewContentSize];
    [self.delegate scrollViewDidScroll:self];
}
-(void)willReszie
{
    [self.actionDelegate willRotateLayout];
}
-(void)resize
{
    NSLog(@"resize");
    if ([self.itemViews count]) {
        [self.actionDelegate rotateLayout];
    }
}
-(NSIndexSet *)getCurrentIndexs
{
    return currentIndexs;
}
-(void)scrollToItemWithOrderIndex:(NSInteger)orderIndex
{
    NSLog(@"scrollToItemWithOrderIndex:%ld",(long)orderIndex);
    if (orderIndex >=0) {
        CGPoint point = self.contentOffset;
        CGPoint newPoint = CGPointMake(self.itemSize.width * orderIndex, point.y);
        self.contentOffset = newPoint;
    }
}
-(void)addItem:(YLazyListItem *)view forIndex:(NSInteger)index
{
    view.tag = index;
    if (view.superview != firstView) {
        [firstView addSubview:view];
        [self.itemViews addObject:view];
    }
    if ([self.actionDelegate respondsToSelector:@selector(viewDidMovedWith:view:)]) {
        [self.actionDelegate viewDidMovedWith:index view:view];
    }
}
-(YLazyListItem *)findViewByIndex:(NSInteger) index
{
    NSArray *subviews = self.itemViews;
    YLazyListItem *result;
    for (NSInteger i=0 ; [subviews count] > i; i++) {
        result = subviews[i];
        if (result.tag == index) {
            break;
        }
    };
    return result;
}
-(void)syncViewForIndexIfNeed:(NSInteger)index
{
    if (self.preventScrollEvent) {
        return;
    }
     NSIndexSet *newIndexs = [self generateRenderIndexs:index];
    if (index < self.itemTotal - 1 && [newIndexs lastIndex] <= self.itemTotal - 1) {
        [self syncViewForIndex:index];
    }
    else{
        index--;
        [self syncViewForIndexIfNeed:index];
    }
}



@end
