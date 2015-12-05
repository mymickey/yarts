//
//  YLazyListView.h
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLazyListItem.h"
@class YLazyListView;
@class YLazyListItem;
//列表协议
@protocol YLazyListViewDelegate <NSObject>
@required
-(YLazyListItem *)listView:(YLazyListView *)listView viewForIndex:(NSInteger )index;//用于创建视图
@end


@protocol YLazyListViewActionDelegate <NSObject>
@required
-(void)viewDidMovedWith:(NSInteger) index view:(YLazyListItem *)item;//视图被移动到新的位置

@end

@interface YLazyListView : UIScrollView
@property (nonatomic) NSInteger lazyItemCount;
@property (nonatomic) NSInteger itemTotal;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) NSInteger focusIndex;
@property (nonatomic) NSInteger orderIndex;
@property (nonatomic,strong,readonly)NSMutableArray<YLazyListItem *> *itemViews;
@property(nonatomic,weak) IBOutlet id<YLazyListViewDelegate>        lazyDelegate;
@property(nonatomic,weak) IBOutlet id<YLazyListViewActionDelegate>  actionDelegate;
-(void)syncViewForIndexIfNeed:(NSInteger) index;
-(void)reload;
-(void)resize;
@end


