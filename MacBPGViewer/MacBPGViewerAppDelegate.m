//
//  AppDelegate.m
//  MacBPGViewer
//
//  Created by Sveinbjorn Thordarson on 02/02/2017.
//  Copyright © 2017 Sveinbjorn Thordarson. All rights reserved.
//

#import "MacBPGViewerAppDelegate.h"

@interface MacBPGViewerAppDelegate ()

@end

@implementation MacBPGViewerAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showLicense:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"License.html" ofType:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://"];
    CFURLRef fromPathURL = NULL;
    OSStatus err = LSGetApplicationForURL((__bridge CFURLRef)url, kLSRolesAll, NULL, &fromPathURL);
    NSString *app = nil;
    
    if (fromPathURL) {
        if (err == noErr) {
            app = [(__bridge NSURL *)fromPathURL path];
        }
        CFRelease(fromPathURL);
    }
    
    if (!app || err) {
        NSLog(@"Unable to find default browser");
        return;
    }
    
    [[NSWorkspace sharedWorkspace] openFile:path withApplication:app];
}

@end
