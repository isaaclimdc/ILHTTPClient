//
//  NSObject+MKBlockAdditions.h
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 25/03/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)();

@interface NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
