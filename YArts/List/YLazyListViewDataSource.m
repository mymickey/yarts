//
//  YLazyListViewDataSource.m
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyListViewDataSource.h"
#import "YLazyListItem.h"
#import "YLazyListItemController.h"
@implementation YLazyListViewDataSource
-(YLazyListItem *)listView:(YLazyListView *)listView viewForIndex:(NSInteger)index
{
    NSLog(@"create view");
    NSArray *arr = @[
          [UIColor redColor],
          [UIColor greenColor],
          [UIColor blueColor],
          [UIColor grayColor],
          [UIColor yellowColor],
          [UIColor purpleColor],
          [UIColor magentaColor],
          [UIColor brownColor],
          [UIColor cyanColor],
          [UIColor orangeColor]
    ];
    UIColor *color = [arr objectAtIndex:(NSUInteger)index];
    YLazyListItemController *itemCtrl = [self.listViewCtrl.storyboard instantiateViewControllerWithIdentifier:@"YLazyListItemController"];
    YLazyListItem *v = (YLazyListItem *)itemCtrl.view;
    v.backgroundColor = color;
    [self.listViewCtrl addChildViewController:itemCtrl];
    [itemCtrl didMoveToParentViewController:self.listViewCtrl];
    return v;
}
@end
