//
//  ViewController.m
//  Remotify
//
//  Created by Ton Smets on 11-06-14.
//  Copyright (c) 2014 Ton Smets. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

/// Button inputs

- (IBAction)playButton:(id)sender {
    [self sendCommand:1];
}

- (IBAction)pauseButton:(id)sender {
    [self sendCommand:0];
}

- (IBAction)prevButton:(id)sender {
    [self sendCommand:2];
}

- (IBAction)nextButton:(id)sender {
    [self sendCommand:3];
}

- (IBAction)infoButton:(id)sender {
    [self updateInfo];
}

- (NSString*) getUrl {
    return self.addressField.text;
}

- (void) updateInfo {
    NSString* url = [self getUrl];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:url
       parameters:@{@"action": @4}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSString* receivedString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
              NSLog(@"Received: %@", receivedString);
              NSString *trackString = [[receivedString componentsSeparatedByString:@" by "] objectAtIndex:0];
              NSString *artistString = [[receivedString componentsSeparatedByString:@" by "] objectAtIndex:1];
              artistString = [[artistString componentsSeparatedByString:@" from "] objectAtIndex:0];
              _infoLabel.text = trackString;
              _artistLabel.text = artistString;
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void) sendCommand:(NSInteger)value {
    NSString* url = [self getUrl];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url
       parameters:@{@"action": [NSString stringWithFormat:@"%ld",(long)value]}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              [self updateInfo];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
