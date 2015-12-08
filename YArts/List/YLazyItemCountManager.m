//
//  YLazyItemCountManager.m
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyItemCountManager.h"
#import "YLazyListItem.h"
@interface YLazyItemCountManager()
{
    CGFloat beforeX;
    NSInteger beforeIndex;
}
@end
@implementation YLazyItemCountManager
-(void)viewDidMovedWith:(NSInteger)index view:(YLazyListItem *)item
{
    [item viewDidFucosWithIndex:index];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = self.lazyListView.orderIndex;
    [self syncView:index];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"scrollViewDidEndDragging");
}
-(void)syncView:(NSInteger)index
{
    [self.lazyListView syncViewForIndexIfNeed:index];
}

@end
