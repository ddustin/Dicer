//
//  XpubPage.h
//  Dicer
//
//  Created by Dustin Dettmer on 12/12/20.
//

#import <UIKit/UIKit.h>
#import "XpubSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface XpubPage : UIViewController<XpubSettings>

@property (strong) NSData *privKey;

@property (strong, nullable) NSString *derivationPath;
@property (strong, nullable) NSString *passphrase;
@property (strong, nullable) NSString *prefix;

@end

NS_ASSUME_NONNULL_END
