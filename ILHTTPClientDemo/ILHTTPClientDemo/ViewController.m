//
//  ViewController.m
//  ILHTTPClientDemo
//
//  Created by Isaac Lim on 1/8/13.
//  Copyright (c) 2013 isaacl.net. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"

#define kWeatherBaseURL @"http://free.worldweatheronline.com/feed/"
#define kAPIKey @"54c86d0def092030130801"
#define kPaloAltoZip 94303

@interface ViewController () {
    ILHTTPClient *client;
    BOOL isCelsius;
}

@end

@implementation ViewController

- (IBAction)refreshWeather:(id)sender {
    [self fetchCurrentWeatherForZip:kPaloAltoZip];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    client = [ILHTTPClient clientWithBaseURL:kWeatherBaseURL
                            showingHUDInView:self.view];

    [self refreshWeather:nil];
}

- (void)fetchCurrentWeatherForZip:(NSUInteger)zip {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", zip], @"q",
                            @"json", @"format",
                            @"2", @"num_of_days",
                            kAPIKey, @"key",
                            nil];

    [client getPath:@"weather.ashx" parameters:params loadingText:@"Getting weather" success:^(AFHTTPRequestOperation *operation, NSString *response) {

        NSDictionary *responseDict = [response JSONValue];
        NSDictionary *currentDict = [[[responseDict objectForKey:@"data"] objectForKey:@"current_condition"] objectAtIndex:0];

        Weather *weather = [[Weather alloc] init];
        weather.tempC = [[currentDict objectForKey:@"temp_C"] integerValue];
        weather.tempF = [[currentDict objectForKey:@"temp_F"] integerValue];
        weather.weatherIconURL = [[[currentDict objectForKey:@"weatherIconUrl"] objectAtIndex:0] objectForKey:@"value"];

        self.weather = weather;
        
        [self updateUI];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"Error: %@", error);
        
    }];
}

- (void)updateUI {
    self.tempLabel.text = [NSString stringWithFormat:@"%d\u00B0",
                           (isCelsius ? self.weather.tempC : self.weather.tempF)];
    
    NSURL *imgURL = [NSURL URLWithString:self.weather.weatherIconURL];
    [self.iconImgView setImageWithURL:imgURL];
}

- (IBAction)toggleCelsius:(id)sender {
    isCelsius = ~isCelsius;
    [self updateUI];
}

@end
