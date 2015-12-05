//
//  YLazyListItem.m
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyListItem.h"
@interface YLazyListItem()
{
}
@end
@implementation YLazyListItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)viewDidFucosWithIndex:(NSInteger)index
{
    //NSLog(@"viewDidFucos %li",(long)index);
    _label.text = [NSString stringWithFormat:@"%li",(long)index];
}

@end
