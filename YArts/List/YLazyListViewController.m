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
    CGFloat rotateBeforeX;
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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}


-(void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [self.scrollView scrollToItemWithOrderIndex:0];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
        self.scrollView.contentOffset = CGPointMake(rotateBeforeX, 0);
    
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    rotateBeforeX = self.scrollView.contentOffset.x;
    [self willReszie];
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self didReszie];
}
-(void)willReszie
{
    self.scrollView.preventScrollEvent = YES;
    [self.scrollView willReszie ];
}
-(void)didReszie
{
    [self.scrollView resize ];
    self.scrollView.preventScrollEvent = NO;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
