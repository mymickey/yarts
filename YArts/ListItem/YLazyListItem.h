//
//  YLazyListItem.h
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLazyListView.h"


@interface YLazyListItem : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void)viewDidFucosWithIndex:(NSInteger)index;
@end
