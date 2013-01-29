//
// ILHTTPClient
// Version 1.11
// Created by Isaac Lim (isaacl.net) on 1/1/13.
//

#import "ILHTTPClient.h"

@interface ILHTTPClient() {
    AFHTTPRequestOperation *_HTTPOperation;
    UIView *_view;
}

@property (strong, nonatomic) AFHTTPRequestOperation *HTTPOperation;
@property (strong, nonatomic) UIView *view;

@property (nonatomic) BOOL isShowingHUD;

@end

@implementation ILHTTPClient

@synthesize HTTPOperation = _HTTPOperation, view = _view;

#pragma mark - Init methods

- (id)initWithBaseURL:(NSString *)baseURL andView:(UIView *)view {
    self = [super initWithBaseURL:[NSURL URLWithString:baseURL]];
    if (self) {
        self.view = view;
    }
    return self;
}

+ (ILHTTPClient *)clientWithBaseURL:(NSString *)baseURL
                   showingHUDInView:(UIView *)view
{
    return [[ILHTTPClient alloc] initWithBaseURL:baseURL andView:view];
}

#pragma mark - Data processing methods

- (void)performOperationWithRequest:(NSURLRequest *)request
                        loadingText:(NSString *)loadingText
                        successText:(NSString *)successText
                            success:(void (^)(AFHTTPRequestOperation *operation,
                                              NSString *response))success
                            failure:(void (^)(AFHTTPRequestOperation *operation,
                                              NSError *error))failure
{
    /* Animate in the HUD */
    [MBProgressHUD fadeInHUDInView:self.view withText:loadingText];
    self.isShowingHUD = YES;

    self.HTTPOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    __block ILHTTPClient *client = self;

    [self.HTTPOperation setCompletionBlockWithSuccess:^
     (AFHTTPRequestOperation *operation, id responseObject) {

         /* Return response string instead of binary data */
         success(operation, operation.responseString);

         /* Animate out the HUD. If successText != nil then show checkmark */
         [MBProgressHUD fadeOutHUDInView:client.view withSuccessText:successText];
         client.isShowingHUD = NO;

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         /* User handles the error */
         failure(operation, error);

         /* Animate out the HUD */
         [MBProgressHUD fadeOutHUDInView:client.view withSuccessText:nil];
         client.isShowingHUD = NO;

     }];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:self.HTTPOperation];
}

#pragma mark - GET Operation

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
    loadingText:(NSString *)loadingText
    successText:(NSString *)successText
        success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURLRequest *request = [self requestWithMethod:@"GET"
                                               path:path
                                         parameters:parameters];

    [self performOperationWithRequest:request
                          loadingText:loadingText
                          successText:successText
                              success:success
                              failure:failure];
}

- (BOOL)isExecuting {
    return self.HTTPOperation.isExecuting;
}

- (BOOL)isPaused {
    return self.HTTPOperation.isPaused;
}

- (void)pauseHTTPOperation {
    [self.HTTPOperation pause];
}

- (void)resumeHTTPOperation {
    [self.HTTPOperation resume];
}

- (void)cancelHTTPOperation {
    [self.HTTPOperation cancel];
}

#pragma mark - POST operation

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
     loadingText:(NSString *)loadingText
     successText:(NSString *)successText
   multiPartForm:(void (^)(id <AFMultipartFormData>formData))multiPartForm
         success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURLRequest *request = [self multipartFormRequestWithMethod:@"POST"
                                                            path:path
                                                      parameters:parameters
                                       constructingBodyWithBlock:multiPartForm];

    [self performOperationWithRequest:request
                          loadingText:loadingText
                          successText:successText
                              success:success
                              failure:failure];
}

- (void)setDownloadProgressAction:(void (^)(NSUInteger bytesRead,
                                            long long totalBytesRead,
                                            long long totalBytesExpectedToRead))progressAction
{
    [self.HTTPOperation setDownloadProgressBlock:progressAction];
}

- (void)setUploadProgressAction:(void (^)(NSUInteger bytesWritten,
                                          long long totalBytesWritten,
                                          long long totalBytesExpectedToWrite))progressAction
{
    [self.HTTPOperation setUploadProgressBlock:progressAction];
}

#pragma mark - DELETE operation

- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
       loadingText:(NSString *)loadingText
       successText:(NSString *)successText
           success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURLRequest *request = [self requestWithMethod:@"DELETE"
                                               path:path
                                         parameters:parameters];

    [self performOperationWithRequest:request
                          loadingText:loadingText
                          successText:successText
                              success:success
                              failure:failure];
}

#pragma mark - PUT operation

- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
    loadingText:(NSString *)loadingText
    successText:(NSString *)successText
  multiPartForm:(void (^)(id <AFMultipartFormData>formData))multiPartForm
        success:(void (^)(AFHTTPRequestOperation *operation, NSString *response))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURLRequest *request = [self multipartFormRequestWithMethod:@"PUT"
                                                            path:path
                                                      parameters:parameters
                                       constructingBodyWithBlock:multiPartForm];
    
    [self performOperationWithRequest:request
                          loadingText:loadingText
                          successText:successText
                              success:success
                              failure:failure];
}

@end
