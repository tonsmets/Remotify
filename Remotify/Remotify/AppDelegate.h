//
//  AppDelegate.h
//  Remotify
//
//  Created by Ton Smets on 09-06-14.
//  Copyright (c) 2014 Ton Smets. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HTTPServer;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    HTTPServer *httpServer;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *infoText;
@property (weak) IBOutlet NSTextField *statusText;

@end
