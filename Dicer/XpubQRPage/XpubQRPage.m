//
//  XpubQRPage.m
//  Dicer
//
//  Created by Dustin Dettmer on 12/13/20.
//

#import "XpubQRPage.h"

@interface XpubQRPage ()

@property (weak) IBOutlet UIImageView *imageView;

@end

@implementation XpubQRPage

- (CGFloat)qrCodeHeight
{
    return 200;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *message = self.xpub;
    
    __weak XpubQRPage *weakSelf = self;
    
    dispatch_async(dispatch_queue_create("QR Code", nil), ^{

        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

        [filter setValue:[message dataUsingEncoding:NSISOLatin1StringEncoding] forKey:@"inputMessage"];

        CIImage *image = filter.outputImage;

        image = [image imageByApplyingTransform:CGAffineTransformMakeScale(self.qrCodeHeight / image.extent.size.width, self.qrCodeHeight / image.extent.size.height)];

        UIImage *uiImage = [UIImage imageWithCIImage:image];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            XpubQRPage *strongSelf = weakSelf;

            strongSelf.imageView.image = uiImage;
        });
    });
}

@end
