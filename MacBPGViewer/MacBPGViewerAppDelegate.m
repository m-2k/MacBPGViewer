/*
 MacBPGViewer - Native open-source BPG image viewer for OS X
 Copyright (c) 2017, Sveinbjorn Thordarson <sveinbjornt@gmail.com>
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 
 3. Neither the name of the copyright holder nor the names of its contributors may
 be used to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
*/

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
