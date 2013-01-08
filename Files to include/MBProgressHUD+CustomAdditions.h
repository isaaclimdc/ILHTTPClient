//
// MBProgressHUD+CustomAdditions.h
// Version 1.0
// Created by Isaac Lim (isaacl.net) on 1/8/13.
//

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2013 isaacl.net. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MBProgressHUD.h"

@interface MBProgressHUD (CustomAdditions)

/**
 * Displays a HUD in the given view with a fade-in animation.
 * @param view The view in which to display the HUD.
 * @param text The text to display in the HUD.
 *
 * @return The instance of the HUD displayed.
 */
+ (MBProgressHUD *)fadeInHUDInView:(UIView *)view withText:(NSString *)text;

/**
 * Hides the HUD currently displayed in the given view with a fade-out animation.
 * @param view The view which currently displays the HUD.
 * @param text The text to display upon successful completion of a task. If nil, then the HUD will simply fade out. If non-nil, then the success text will be briefly displayed along with a checkmark before fading out.
 *
 * @return The instance of the HUD displayed.
 */
+ (void)fadeOutHUDInView:(UIView *)view withSuccessText:(NSString *)text;

@end

/* Perform Block After Delay */
@interface NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end

@implementation NSObject (PerformBlockAfterDelay)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    block = [block copy];

    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end
