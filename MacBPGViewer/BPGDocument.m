//
//  Document.m
//  MacBPGViewer
//
//  Created by Sveinbjorn Thordarson on 02/02/2017.
//  Copyright © 2017 Sveinbjorn Thordarson. All rights reserved.
//

#import "BPGDocument.h"
#import "HCImage+BPG.h"

@interface BPGDocument ()
{
    IBOutlet NSImageView *imageView;
    NSImage *bpgImage;
}

@end

@implementation BPGDocument

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName {
    return @"BPGDocument";
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    return nil;
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    
    if (data == nil) {
        *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadUnknownError userInfo:nil];
        return NO;
    }
    
    bpgImage = [NSImage imageWithBPGData:data];
    if (bpgImage == nil) {
        *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadUnknownError userInfo:nil];
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
