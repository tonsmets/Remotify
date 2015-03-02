//
//  MyHTTPConnection.m
//  Remotify
//
//  Created by Ton Smets on 09-06-14.
//  Copyright (c) 2014 Ton Smets. All rights reserved.
//

#import "MyHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"

// Log levels : off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN; // | HTTP_LOG_FLAG_TRACE;
@implementation MyHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
	HTTPLogTrace();
	
	// Add support for POST
	
	if ([method isEqualToString:@"POST"])
	{
		if ([path isEqualToString:@"/"])
		{
			// Let's be extra cautious, and make sure the upload isn't 5 gigs
			
			return requestContentLength < 50;
		}
	}
	
	return [super supportsMethod:method atPath:path];
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
	HTTPLogTrace();
	
	// Inform HTTP server that we expect a body to accompany a POST request
	
	if([method isEqualToString:@"POST"])
		return YES;
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	HTTPLogTrace();
	
	if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/"])
    //if ([method isEqualToString:@"POST"])
	{
		HTTPLogVerbose(@"%@[%p]: postContentLength: %qu", THIS_FILE, self, requestContentLength);
		
		NSString *postStr = nil;
		
		NSData *postData = [request body];
		if (postData)
		{
			postStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
		}
		
		HTTPLogVerbose(@"%@[%p]: postStr: %@", THIS_FILE, self, postStr);
		
		// Result will be of the form "answer=..."
		
		int answer = [[postStr substringFromIndex:7] intValue];
		
		NSData *response = nil;

        if(answer == 0) {
            NSTask *task;
            task = [[NSTask alloc] init];
            NSString *execPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tune-control"];
            [task setLaunchPath: execPath];
            
            NSArray *arguments;
            arguments = [NSArray arrayWithObjects: @"pause", nil];
            [task setArguments: arguments];
            
            NSPipe *pipe;
            pipe = [NSPipe pipe];
            [task setStandardOutput: pipe];
            
            NSFileHandle *file;
            file = [pipe fileHandleForReading];
            
            [task launch];
            
            NSData *data;
            data = [file readDataToEndOfFile];
            
            NSString *string;
            string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog (@"Returned:\n%@", string);
        }
        if(answer == 1) {
            NSTask *task;
            task = [[NSTask alloc] init];
            NSString *execPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tune-control"];
            [task setLaunchPath: execPath];
            
            NSArray *arguments;
            arguments = [NSArray arrayWithObjects: @"play", nil];
            [task setArguments: arguments];
            
            NSPipe *pipe;
            pipe = [NSPipe pipe];
            [task setStandardOutput: pipe];
            
            NSFileHandle *file;
            file = [pipe fileHandleForReading];
            
            [task launch];
            
            NSData *data;
            data = [file readDataToEndOfFile];
            
            NSString *string;
            string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog (@"Returned:\n%@", string);
        }
        
        if(answer == 2) {
            NSTask *task;
            task = [[NSTask alloc] init];
            NSString *execPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tune-control"];
            [task setLaunchPath: execPath];
            
            NSArray *arguments;
            arguments = [NSArray arrayWithObjects: @"prev", nil];
            [task setArguments: arguments];
            
            NSPipe *pipe;
            pipe = [NSPipe pipe];
            [task setStandardOutput: pipe];
            
            NSFileHandle *file;
            file = [pipe fileHandleForReading];
            
            [task launch];
            
            NSData *data;
            data = [file readDataToEndOfFile];
            
            NSString *string;
            string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog (@"Returned:\n%@", string);
        }
        
        if(answer == 3) {
            NSTask *task;
            task = [[NSTask alloc] init];
            NSString *execPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tune-control"];
            [task setLaunchPath: execPath];
            
            NSArray *arguments;
            arguments = [NSArray arrayWithObjects: @"next", nil];
            [task setArguments: arguments];
            
            NSPipe *pipe;
            pipe = [NSPipe pipe];
            [task setStandardOutput: pipe];
            
            NSFileHandle *file;
            file = [pipe fileHandleForReading];
            
            [task launch];
            
            NSData *data;
            data = [file readDataToEndOfFile];
            
            NSString *string;
            string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog (@"Returned:\n%@", string);
        }
        
        if(answer == 4) {
            NSTask *task;
            task = [[NSTask alloc] init];
            NSString *execPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tune-control"];
            [task setLaunchPath: execPath];
            
            NSArray *arguments;
            arguments = [NSArray arrayWithObjects: @"track", nil];
            [task setArguments: arguments];
            
            NSPipe *pipe;
            pipe = [NSPipe pipe];
            [task setStandardOutput: pipe];
            
            NSFileHandle *file;
            file = [pipe fileHandleForReading];
            
            [task launch];
            
            NSData *data;
            data = [file readDataToEndOfFile];
            
            NSString *string;
            string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog (@"Returned:\n%@", string);
            response = [string dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        if(answer == 5) {
            NSTask *task;
            task = [[NSTask alloc] init];
            NSString *execPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tune-control"];
            [task setLaunchPath: execPath];
            
            NSArray *arguments;
            arguments = [NSArray arrayWithObjects: @"state", nil];
            [task setArguments: arguments];
            
            NSPipe *pipe;
            pipe = [NSPipe pipe];
            [task setStandardOutput: pipe];
            
            NSFileHandle *file;
            file = [pipe fileHandleForReading];
            
            [task launch];
            
            NSData *data;
            data = [file readDataToEndOfFile];
            
            NSString *string;
            string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog (@"Returned:\n%@", string);
            response = [string dataUsingEncoding:NSUTF8StringEncoding];
        }
		
		return [[HTTPDataResponse alloc] initWithData:response];
	}
	
	return [super httpResponseForMethod:method URI:path];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength
{
	HTTPLogTrace();
	
	// If we supported large uploads,
	// we might use this method to create/open files, allocate memory, etc.
}

- (void)processBodyData:(NSData *)postDataChunk
{
	HTTPLogTrace();
	
	// Remember: In order to support LARGE POST uploads, the data is read in chunks.
	// This prevents a 50 MB upload from being stored in RAM.
	// The size of the chunks are limited by the POST_CHUNKSIZE definition.
	// Therefore, this method may be called multiple times for the same POST request.
	
	BOOL result = [request appendData:postDataChunk];
	if (!result)
	{
		HTTPLogError(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
	}
}


@end
