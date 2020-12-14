//
//  SeedPage.m
//  Dicer
//
//  Created by Dustin Dettmer on 12/12/20.
//

#import "SeedPage.h"
#import "BTCUtil.h"

@interface SeedPage ()

@property (weak) UITextView *outputField;

@end

@implementation SeedPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DataTrackPush();
    
    String rawStr = toMnemonic(DataRef((void*)self.privKey.bytes, (int)self.privKey.length));
    
    NSString *str = [NSString stringWithCString:rawStr.bytes encoding:NSUTF8StringEncoding];
    
    DataTrackPop();
    
    self.outputField.text = @"";
    
    int index = 0;
    
    for(NSString *word in [str componentsSeparatedByString:@" "])
        self.outputField.text = [self.outputField.text stringByAppendingFormat:@"%4d: %@\n", ++index, word];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController respondsToSelector:@selector(setPrivKey:)]) {
        
        id obj = segue.destinationViewController;
        
        [obj setPrivKey:self.privKey];
    }
}

@end
