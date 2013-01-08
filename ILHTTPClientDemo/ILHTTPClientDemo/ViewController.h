//
//  ViewController.h
//  ILHTTPClientDemo
//
//  Created by Isaac Lim on 1/8/13.
//  Copyright (c) 2013 isaacl.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
#import "ILHTTPClient.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) Weather *weather;
@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;

@end
