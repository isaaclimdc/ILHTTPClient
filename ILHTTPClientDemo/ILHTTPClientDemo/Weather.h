//
//  Weather.h
//  ILHTTPClientDemo
//
//  Created by Isaac Lim on 1/8/13.
//  Copyright (c) 2013 isaacl.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic) NSInteger tempC;
@property (nonatomic) NSInteger tempF;
@property (strong, nonatomic) NSString *weatherIconURL;

@end
