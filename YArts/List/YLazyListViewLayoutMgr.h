//
//  YLazyListViewLayoutMgr.h
//  YArts
//
//  Created by mickey on 15/12/5.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLazyListView.h"
@interface YLazyListViewLayoutMgr : NSObject<YLazyListViewActionDelegate>
@property (weak, nonatomic) IBOutlet YLazyListView *lazyListView;

@end
