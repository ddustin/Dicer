//
//  XpubPage.m
//  Dicer
//
//  Created by Dustin Dettmer on 12/12/20.
//

#import "XpubPage.h"
#import "BTCUtil.h"
#import "XpubQRPage.h"

@interface XpubPage ()

@property (weak) UITextView *outputField;

@end

@implementation XpubPage

- (NSString*)xpub
{
    DataTrackPush();
    
    Data seedPhrase = DataCopy("Bitcoin seed", strlen("Bitcoin seed"));
    
    String sentence = toMnemonic(DataRef((void*)self.privKey.bytes, (int)self.privKey.length));
    
    Data seed = PBKDF2(sentence.bytes, self.passphrase.UTF8String);
    
    Data hash = hmacSha512(seedPhrase, seed);
    
    Data masterKey = DataRef(hash.bytes, 32);
    Data chainCode = DataRef(hash.bytes + 32, 32);
    
    Data wallet = hdWalletPriv(masterKey, chainCode);
    
    wallet = hdWallet(wallet, self.derivationPath.UTF8String);
    
    Data publicWallet = publicHdWallet(wallet);
    
    if(self.prefix.length) {
        
        NSDictionary<NSString*,NSNumber*> *knownPrefixes =
        @{
            @"xpub": @0x0488b21e,
            @"ypub": @0x049d7cb2,
            @"zpub": @0x04b24746,
            @"Ypub": @0x0295b43f,
            @"Zpub": @0x02aa7ed3,
        };
        
        NSString *key = self.prefix;
        
        if(!knownPrefixes[key])
            key = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if(!knownPrefixes[key])
            return [NSString stringWithFormat:@"prefix must be one of: %@", knownPrefixes.allKeys];
        
        publicWallet = hdWalletSetVersion(publicWallet, knownPrefixes[key].unsignedIntValue);
    }
    
    String rawStr = base58Encode(publicWallet);
    
    NSString *result = [NSString stringWithUTF8String:rawStr.bytes];
    
    DataTrackPop();
    
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.derivationPath = @"m/44'/0'/0'";
    
    self.outputField.text = self.xpub;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.outputField.text = self.xpub;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"qr"]) {
        
        XpubQRPage *page = segue.destinationViewController;
        
        page.xpub = self.xpub;
    }
    
    if([segue.identifier isEqual:@"settings"]) {
        
        XpubSettings *page = segue.destinationViewController;
        
        page.passphrase = self.passphrase;
        page.derivationPath = self.derivationPath;
        page.prefix = self.prefix;
        
        page.delegate = self;
    }
}

@end
