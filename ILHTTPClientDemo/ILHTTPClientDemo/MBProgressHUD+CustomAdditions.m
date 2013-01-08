//
//  MBProgressHUD+CustomAdditions.m
//  buUukified
//
//  Created by Isaac Lim on 7/20/12.
//
//

#import "MBProgressHUD+CustomAdditions.h"

@implementation MBProgressHUD (CustomAdditions)

+ (void)showAnimatedHUDInView:(UIView *)view withText:(NSString *)text
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  
  MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
  HUD.labelText = text;
}

+ (void)completeAnimatedHUDForView:(UIView *)view withText:(NSString *)text
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
  MBProgressHUD *HUD = [MBProgressHUD HUDForView:view];
  HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
  HUD.mode = MBProgressHUDModeCustomView;
  HUD.labelText = text;
  [self performBlock:^{
    [MBProgressHUD hideHUDForView:view animated:YES];
  } afterDelay:SLEEP_DELAY];
}

+ (void)hideAnimatedHUDForView:(UIView *)view
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
  [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hideAllAnimatedHUDsForView:(UIView *)view
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
  [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
