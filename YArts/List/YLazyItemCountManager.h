//
//  YLazyItemCountManager.h
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KZBehaviour.h"
#import "YLazyListView.h"
@interface YLazyItemCountManager : KZBehaviour<UIScrollViewDelegate,YLazyListViewActionDelegate>
@property (weak, nonatomic) IBOutlet YLazyListView *lazyListView;

@end
