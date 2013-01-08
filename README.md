ILHTTPClient
============

A wrapper around AFNetworking with an auto loading HUD.

### Version 1.0

Overview
--------
`ILHTTPClient` is a thin wrapper around `AFNetworking` that automatically fades in and out an `MBProgressHUD` HUD for each request made. It exposes several easy-to-use methods to make each of the four *verbs* in HTTP requests: GET, POST, DELETE and PUT.

Responses returned by the HTTP requests made are in `NSString` plain text form, and can be converted to JSON objects (if the context is appropriate), using a built-in method `-JSONValue` on the `NSString`. Currently, only plain-text and JSON formats are supported.

How to use
----------
A demo project `ILHTTPClientDemo` is included to show how `ILHTTPClient` can be integrated into a project.

#### Preparation
1. Copy all files in the "Files to include" folder into your Xcode project. Be sure to check "Copy items into destination's group folder". These files include:
    - `37x-Checkmark.png`
    - `37x-Checkmark@2x.png`
    - `ILHTTPClient.h`
    - `ILHTTPClient.m`
    - `MBProgressHUD+CustomAdditions.h`
    - `MBProgressHUD+CustomAdditions.m`
2. Include the `AFNetworking` library into your project by [downloading](https://github.com/AFNetworking/AFNetworking) the latest version, and copying only the `AFNetworking` folder into your project.
3. Include the `MBProgressHUD` library into your project by [downloading](https://github.com/jdg/MBProgressHUD) the latest version, and copying the 2 files `MBProgressHUD.h` and `MBProgressHUD.m` into your project.
4. Add the `SystemConfiguration` and `MobileCoreServices` framework to your project by clicking on your project's name at the top of the sidebar in Xcode, then going into "Build Phases". In this tab, expand "Link Binaries With Libraries" and add `SystemConfiguration.framework`. Do the same for `MobileCoreServices.framework`. `AFNetworking` requires these two frameworks.
5. Add the line `#include "ILHTTPClient.h"` to the interface of the view controller that you wish to use `ILHTTPClient` in. If you intend to use `ILHTTPClient` in multiple view controllers,  add the above include line to the `YourAppName-Prefix.pch` file in the "Supporting Files" group. This way, `ILHTTPClient` will be available to every file in your project without needing to keep adding a `#include`.
6. Also, in the `YourAppName-Prefix.pch` file, add:

        #import <SystemConfiguration/SystemConfiguration.h>
        #import <MobileCoreServices/MobileCoreServices.h>
        
#### Initializing an `ILHTTPClient` client
1. In the `-viewDidLoad:` of the view controller, initialize either a local or global ivar by calling:

        ILHTTPClient *client = [ILHTTPClient clientWithBaseURL:<Base URL here>
                                              showingHUDInView:<View here>];
                       
   And assign the result of this method call to the ivar client. Note that the view given should be the one you want to display the HUD in (usually `self.view`). The client only needs to be initialized once per set of requests with the same base URL.

#### Making a GET request
1. Use the following method. `params` is an NSDictionary containing the key-value pairs of any parameters needed to be passed into the request. `loadingText` is rhe text to show in the HUD while the request is executing. `success` and `failure` are the callback blocks.

        [client getPath:path parameters:params loadingText:@"Loading"
          success:^(AFHTTPRequestOperation *operation, NSString *response) {
   
            id JSON = [response JSONValue]; //If JSON is returned
            /* Do something with this data */

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            NSLog(@"Error: %@", error);
            /* Handle the error here */
        
        }];

#### Making a POST request
1. Use the following method. The parameters are all the same as for the GET request, except for `multiPartForm`. In this block, use the methods declared in `AFHTTPClient.h` to compose the `AFMultipartFormData` object. One such example is to use `-appendPartWithFileData:name:` to compose the POST request body.

        [client postPath:path parameters:params loadingText:@"Submitting" 
          multiPartForm:^(id<AFMultipartFormData> formData) {
          
            /* Compose POST request body here */
              
        } success:^(AFHTTPRequestOperation *operation, NSString *response) {
        
            id JSON = [response JSONValue]; //If JSON is returned
            /* Do something with this data */
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            NSLog(@"Error: %@", error);
            /* Handle the error here */
            
        }];

#### Making DELETE and PUT requests
The same technique as demonstrated above goes for the DELETE and PUT operations, except using the `-deletePath:…` and `putPath:…` methods respectively. There is a range of other methods that can be used to interact with the HTTP operation, but I won't go into detail here.

Requirements
------------
- ARC
- iOS 5.0 or later
- The `AFNetworking` library
- The `MBProgressHUD` library
- The `SystemConfiguration` framework
- The `MobileCoreServcies` framework

Contact
-------
Isaac Lim  
[isaacl.net](http://isaacl.net)

Version History
---------------
**1.0**
- First publish to Github

License
-------
 ILSideScrollView is distributed under the terms and conditions of the MIT license.

 Copyright (c) 2013 isaacl.net. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
