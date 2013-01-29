//
// ILHTTPClient
// Version 1.11
// Created by Isaac Lim (isaacl.net) on 1/1/13.
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

#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD+CustomAdditions.h"

@interface ILHTTPClient : AFHTTPClient

@property (nonatomic, readonly) BOOL isShowingHUD;

+ (ILHTTPClient *)clientWithBaseURL:(NSString *)baseURL
                   showingHUDInView:(UIView *)view;

/**
 * Performs a GET HTTP Request, automatically showing a loading HUD.
 * @param path The path of the desired resource, relative to the base URL as designated in @see clientWithBaseURL:showingHUDInView:
 * @param parameters An NSDictionary containing the parameters of the request.
 * @param loadingText The text to show in the HUD while the request is executing.
 * @param successText The text to show in the HUD when the request completes successfully. If nil, the HUD will just fade away. If non-nil, a checkmark will be shown along with the text.
 * @param success The callback block to perform upon success.
 * @param failure The callback block to perform upon failure.
 *
 * @return none (asynchronous method)
 */
- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
    loadingText:(NSString *)loadingText
    successText:(NSString *)successText
        success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (BOOL)isExecuting;
- (BOOL)isPaused;
- (void)pauseHTTPOperation;
- (void)resumeHTTPOperation;
- (void)cancelHTTPOperation;

/**
 * Performs a POST HTTP Request, automatically showing a loading HUD.
 * @param path The path of the desired resource, relative to the base URL as designated in @see clientWithBaseURL:showingHUDInView:
 * @param parameters An NSDictionary containing the parameters of the request.
 * @param loadingText The text to show in the HUD while the request is executing.
 * @param successText The text to show in the HUD when the request completes successfully. If nil, the HUD will just fade away. If non-nil, a checkmark will be shown along with the text.
 * @param multiPartForm The form containing the POST data.
 * @param success The callback block to perform upon success.
 * @param failure The callback block to perform upon failure.
 *
 * @return none (asynchronous method)
 */
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
     loadingText:(NSString *)loadingText
     successText:(NSString *)successText
   multiPartForm:(void (^)(id <AFMultipartFormData>formData))multiPartForm
         success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)setDownloadProgressAction:(void (^)(NSUInteger bytesRead,
                                            long long totalBytesRead,
                                            long long totalBytesExpectedToRead))progressAction;
- (void)setUploadProgressAction:(void (^)(NSUInteger bytesWritten,
                                          long long totalBytesWritten,
                                          long long totalBytesExpectedToWrite))progressAction;

/**
 * Performs a DELETE HTTP Request, automatically showing a loading HUD.
 * @param path The path of the desired resource, relative to the base URL as designated in @see clientWithBaseURL:showingHUDInView:
 * @param parameters An NSDictionary containing the parameters of the request.
 * @param loadingText The text to show in the HUD while the request is executing.
 * @param successText The text to show in the HUD when the request completes successfully. If nil, the HUD will just fade away. If non-nil, a checkmark will be shown along with the text.
 * @param success The callback block to perform upon success.
 * @param failure The callback block to perform upon failure.
 *
 * @return none (asynchronous method)
 */
- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
       loadingText:(NSString *)loadingText
       successText:(NSString *)successText
           success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 * Performs a PUT HTTP Request, automatically showing a loading HUD.
 * @param path The path of the desired resource, relative to the base URL as designated in @see clientWithBaseURL:showingHUDInView:
 * @param parameters An NSDictionary containing the parameters of the request.
 * @param loadingText The text to show in the HUD while the request is executing.
 * @param successText The text to show in the HUD when the request completes successfully. If nil, the HUD will just fade away. If non-nil, a checkmark will be shown along with the text.
 * @param multiPartForm The form containing the PUT data.
 * @param success The callback block to perform upon success.
 * @param failure The callback block to perform upon failure.
 *
 * @return none (asynchronous method)
 */
- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
    loadingText:(NSString *)loadingText
    successText:(NSString *)successText
  multiPartForm:(void (^)(id <AFMultipartFormData>formData))multiPartForm
        success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

@interface NSString (JSONAdditions)
/**
 * Converts the receiver NSString into JSON format.
 * @param none
 *
 * @return The JSON object, e.g. an NSDictionary.
 */
- (id)JSONValue;
@end

@implementation NSString (JSONAdditions)
- (id)JSONValue {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}
@end