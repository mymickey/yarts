//
//  NSIndexSet+Util.m
//  YArts
//
//  Created by mickey on 15/11/29.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "NSIndexSet+Util.h"

@implementation NSIndexSet (Util)
-(NSIndexSet *)primeIndex:(NSInteger)index
{
    NSInteger len = [self count];
    if (index == 0) {
        return [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(index, len)];
    }
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:@(index)];
    NSInteger before = index;
    NSInteger after = index;;
    while ([arr count] != len) {
        before--;
        after++;
        if (before >= 0) {
            [arr insertObject:@(before) atIndex:0];
        }
        
        [arr insertObject:@(after) atIndex:[arr count]];
    }
    NSMutableIndexSet *indexs = [NSMutableIndexSet new];
    for (NSInteger i=0; [arr count] > i ; i++) {
        [indexs addIndex:[[arr objectAtIndex:i] integerValue]];
    }
    return indexs;
}
//将第一个与第二个中不一样的index拿出来
+(NSIndexSet *)diffIndexs:(NSIndexSet *)indexs otherIndexs:(NSIndexSet *)indexs2
{
     NSMutableIndexSet *result = [NSMutableIndexSet new];
    [indexs enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (![indexs2 containsIndex:idx]) {
            [result addIndex:idx];
        }
    }];
    return result;
}
-(NSMutableArray *)toArray
{
    NSMutableArray *result = [NSMutableArray new];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:@(idx)];
    }];
    return result;
}
@end
