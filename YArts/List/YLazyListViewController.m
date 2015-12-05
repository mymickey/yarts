//
//  YLazyListViewController.m
//  YArts
//
//  Created by mickey on 15/11/28.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "YLazyListViewController.h"
#import "YLazyListView.h"
@interface YLazyListViewController ()
{
}
@end

@implementation YLazyListViewController

-(void)awakeFromNib
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self addChildViewController:self];
    self.scrollView.lazyItemCount = 3;
    self.scrollView.itemTotal = 10;
    self.scrollView.itemSize = CGSizeZero;

    // Do any additional setup after loading the view.
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"willRotateToInterfaceOrientation    l");
    [self.scrollView resize ];
}
-(BOOL)shouldAutorotate
{
    return YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.scrollView reload];
    CGRect frame = [UIScreen mainScreen].bounds;
    self.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollViewDidScroll by ctrl");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
