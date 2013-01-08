//
//  NSObject+MKBlockAdditions.m
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 25/03/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "NSObject+PerformBlockAfterDelay.h"

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
  block = [block copy];
  [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block
{
  block();
}

@end
