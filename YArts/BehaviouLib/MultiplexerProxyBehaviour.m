//
//  MultiplexerProxyBehaviour.m
//  BehaviourExample
//
//  Copyright (c) 2014 pixle. All rights reserved.
//

#import "MultiplexerProxyBehaviour.h"

@implementation MultiplexerProxyBehaviour
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
   
    NSMethodSignature *sig = [super methodSignatureForSelector:sel];
    if (!sig) {
        for (id obj in self.targets) {
            //NSLog(@"class is:%@, selector:%@ ,NSMethodSignature:%@",[obj class],NSStringFromSelector(sel),[obj methodSignatureForSelector:sel]);
            if ((sig = [obj methodSignatureForSelector:sel])) {
                break;
            }
        }
    }
    return sig;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL base = [super respondsToSelector:aSelector];
    if (base) {
        return base;
    }
    BOOL responds = NO;
    for (id obj in self.targets) {
        if ([obj respondsToSelector:aSelector]) {
            responds=YES;
            break;
        }
    }
    return responds;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    for (id obj in self.targets) {
        if ([obj respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:obj];
        }
    }
}
@end
