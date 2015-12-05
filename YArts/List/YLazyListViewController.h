//
//  YLazyListViewController.h
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLazyListView.h"


@interface YLazyListViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet YLazyListView *scrollView;

@end


