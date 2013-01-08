//
// MBProgressHUD+CustomAdditions.m
// Version 1.0
// Created by Isaac Lim (isaacl.net) on 1/8/13.
//

#import "MBProgressHUD+CustomAdditions.h"

#define SLEEP_DELAY 1.0f

@implementation MBProgressHUD (CustomAdditions)

+ (MBProgressHUD *)fadeInHUDInView:(UIView *)view withText:(NSString *)text {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelText = text;

    return HUD;
}

+ (void)fadeOutHUDInView:(UIView *)view withSuccessText:(NSString *)text {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    if (text) {
        MBProgressHUD *HUD = [MBProgressHUD HUDForView:view];
        HUD.customView = [[UIImageView alloc] initWithImage:
                          [UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = text;

        [self performBlock:^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        } afterDelay:SLEEP_DELAY];
    }
    else {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }
}

@end
