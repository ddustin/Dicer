//
//  XpubSettings.h
//  Dicer
//
//  Created by Dustin Dettmer on 12/13/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XpubSettings <NSObject>

- (void)setDerivationPath:(NSString*)derivationPath;
- (void)setPassphrase:(NSString*)passphrase;
- (void)setPrefix:(NSString*)prefix;

@end

@interface XpubSettings : UIViewController

@property (weak) id<XpubSettings> delegate;

@property (strong, nullable) NSString *derivationPath;
@property (strong, nullable) NSString *passphrase;
@property (strong, nullable) NSString *prefix;

@end

NS_ASSUME_NONNULL_END
