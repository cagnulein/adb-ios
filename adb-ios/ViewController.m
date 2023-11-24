//
//  ViewController.m
//  adb-ios
//
//  Created by Li Zonghai on 9/28/15.
//  Copyright (c) 2015 Li Zonghai. All rights reserved.
//

#import "ViewController.h"
#import "adb/AdbClient.h"


#define IP  "localhost:5555"

@interface ViewController ()
@property(strong) AdbClient *adb;

@end

@implementation ViewController
@synthesize adb = _adb;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adb = [[AdbClient alloc] initWithVerbose:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) list:(id)sender
{
    
    [_adb shell:@"input swipe 100 200 300 400 200" didResponse:^(BOOL succ, NSString *result) {
        @autoreleasepool {
                NSDate *currentDate = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

                // Customize the date format
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

                NSString *dateString = [formatter stringFromDate:currentDate];
                NSLog(@"Current Date and Time: %@ swipe!", dateString);
            }
    }];
}


-(IBAction)connectBtn:(id)sender
{
    [_adb connect:@IP didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];

    }];
}

-(IBAction)installApkBtn:(id)sender
{
    NSString *apkPath = [[NSBundle mainBundle] pathForResource:@"Term" ofType:@"apk"];
    [_adb installApk:apkPath flags:ADBInstallFlag_Replace didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)uninstallApkBtn:(id)sender
{
    [_adb uninstallApk:@"jackpal.androidterm" didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)startApk:(id)sender
{
    [_adb shell:@"am start jackpal.androidterm/.Term" didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)disconnect:(id)sender
{
    [_adb disconnect:@IP didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)ps:(id)sender
{
    [_adb shell:@"logcat -b all -d " didResponse:^(BOOL succ, NSString *result) {
     
        @autoreleasepool {
                NSDate *currentDate = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

                // Customize the date format
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

                NSString *dateString = [formatter stringFromDate:currentDate];
                NSLog(@"Current Date and Time: %@ %@", dateString, result);
            }
    }];
}




@end
