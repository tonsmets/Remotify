//
//  AppDelegate.m
//  Remotify
//
//  Created by Ton Smets on 09-06-14.
//  Copyright (c) 2014 Ton Smets. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "GCDAsyncSocket.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // Initalize our http server
	httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
    [httpServer setPort:12345];
	
	// We're going to extend the base HTTPConnection class with our MyHTTPConnection class.
	// This allows us to do all kinds of customizations.
	[httpServer setConnectionClass:[MyHTTPConnection class]];
	
	// Serve files from our embedded Web folder
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	DDLogInfo(@"Setting document root: %@", webPath);
	
	[httpServer setDocumentRoot:webPath];
    
    NSError *error = nil;
	if(![httpServer start:&error])
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
    else {
        [[[NSHost currentHost] addresses] objectAtIndex:0];
        NSString *textoutput = [NSString stringWithFormat:@"Started server at: %@:%i", [[[NSHost currentHost] addresses] objectAtIndex:0], httpServer.port];
        NSString *urlTemp = [NSString stringWithFormat:@"http://%@:%i", [[[NSHost currentHost] addresses] objectAtIndex:0], httpServer.port];
        // both are needed, otherwise hyperlink won't accept mousedown
        [self.statusText setAllowsEditingTextAttributes: YES];
        [self.statusText setSelectable: YES];
        
        NSURL* url = [NSURL URLWithString:urlTemp];
        
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:textoutput];
        [string addAttribute: NSLinkAttributeName value:url range: NSMakeRange(0, string.length)];
        
        // set the attributed string to the NSTextField
        [self.statusText setAttributedStringValue: string];
    }
    [self updateInfo];
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(timerAction)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void) timerAction {
    //NSLog(@"Will appear after a 2 second delay.");
    [self updateInfo];
}


- (void) updateInfo {
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
    [self.infoText setStringValue:string];
}

- (IBAction)getInfo:(id)sender {
    [self updateInfo];
}

- (IBAction)playButton:(id)sender {
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


- (IBAction)pauseButton:(id)sender {
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

- (IBAction)previousButton:(id)sender {
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
    [self updateInfo];
}

- (IBAction)nextButton:(id)sender {
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
    [self updateInfo];
}


@end
