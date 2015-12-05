//
//  NSArray+slice.m
//  YArts
//
//  Created by mickey on 15/11/29.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import "NSArray+slice.h"

@implementation NSArray (slice)
-(NSArray *)sliceStart:(NSInteger)start end:(NSInteger)end
{
    if (start == end) {
        end--;
    }
    return [self subarrayWithRange:NSMakeRange(start, end)];
    NSArray *result;
    @try{
        result = [self subarrayWithRange:NSMakeRange(start, end)];
    }
    @catch(NSException *exception){
        result = [self sliceStart:start end:end -1];
    }
    @finally{
        NSLog(@"f");
    }
    return result;
}
@end
