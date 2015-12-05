//
//  NSIndexSet+Util.h
//  YArts
//
//  Created by mickey on 15/11/29.
//  Copyright © 2015年 mickey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexSet (Util)
-(NSIndexSet *)primeIndex:(NSInteger)index;
+(NSIndexSet *)diffIndexs:(NSIndexSet *)indexs otherIndexs:(NSIndexSet *)indexs2;
-(NSMutableArray *)toArray;
@end
