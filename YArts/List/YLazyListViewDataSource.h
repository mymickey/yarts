//
//  YLazyListViewDataSource.h
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLazyListViewController.h"
@interface YLazyListViewDataSource : NSObject<YLazyListViewDelegate>
@property (weak, nonatomic) IBOutlet YLazyListViewController *listViewCtrl;

@end
