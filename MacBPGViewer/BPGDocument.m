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

#import "BPGDocument.h"
#import "HCImage+BPG.h"

@interface BPGDocument ()
{
    IBOutlet NSImageView *imageView;
    NSImage *bpgImage;
}
@end

@implementation BPGDocument

- (NSString *)windowNibName {
    return @"BPGDocument";
}

- (BOOL)hasValidBPGMagicHeader:(NSData *)imageData {
    if ([imageData length] < 4) {
        return NO;
    }
    
    NSData *headerMagicData = [imageData subdataWithRange:NSMakeRange(0, 4)];
    char magic[] = { 0x42, 0x50, 0x47, 0xFB }; // BPG magic header
    NSData *expectedHeaderMagicData = [NSData dataWithBytes:&magic length:4];
    
    return [headerMagicData isEqualToData:expectedHeaderMagicData];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    
    if (data == nil || [self hasValidBPGMagicHeader:data] == NO) {
        *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadCorruptFileError userInfo:nil];
        return NO;
    }
    
    bpgImage = [NSImage imageWithBPGData:data];
    if (bpgImage == nil) {
        *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadCorruptFileError userInfo:nil];
        return NO;
    }
    
    return YES;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    
    NSImageRep *rep = [[bpgImage representations] objectAtIndex:0];
    NSSize imageSize = NSMakeSize(rep.pixelsWide, rep.pixelsHigh);

    NSWindow *window = [self.windowControllers firstObject].window;
    
    NSRect frame = [window frame];
    frame.size = imageSize;
    [window setFrame:frame display:NO animate:NO];
    
    [imageView setImage:bpgImage];
}

@end
