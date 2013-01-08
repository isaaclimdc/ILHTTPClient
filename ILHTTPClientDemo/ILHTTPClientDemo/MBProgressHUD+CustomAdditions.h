//
//  MBProgressHUD+CustomAdditions.h
//  buUukified
//
//  Created by Isaac Lim on 7/20/12.
//
//

#import "MBProgressHUD.h"
#import "NSObject+PerformBlockAfterDelay.h"

#define SLEEP_DELAY 1.0f

@interface MBProgressHUD (CustomAdditions)

+ (void)showAnimatedHUDInView:(UIView *)view withText:(NSString *)text;
+ (void)completeAnimatedHUDForView:(UIView *)view withText:(NSString *)text;
+ (void)hideAnimatedHUDForView:(UIView *)view;
+ (void)hideAllAnimatedHUDsForView:(UIView *)view;

@end
