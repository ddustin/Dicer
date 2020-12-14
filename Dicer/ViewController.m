//
//  ViewController.m
//  Dicer
//
//  Created by Dustin Dettmer on 12/12/20.
//

#import "ViewController.h"
#import "BTCUtil.h"

@interface ViewController ()

@property (weak) IBOutlet UITextField *inputField;
@property (weak) IBOutlet UITextView *outputField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateHash];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.inputField becomeFirstResponder];
}

- (NSData*)privKey
{
    NSData *data = [self.inputField.text dataUsingEncoding:NSUTF8StringEncoding];
    
    DataTrackPush();
    
    Data result = sha256(DataRef((void*)data.bytes, (int)data.length));
    
    NSData *dataResult = [NSData dataWithBytes:result.bytes length:result.length];
    
    DataTrackPop();
    
    return dataResult;
}

- (IBAction)updateHash
{
    DataTrackPush();
    
    String result = toHex(DataRef((void*)self.privKey.bytes, (int)self.privKey.length));
    
    self.outputField.text = [NSString stringWithCString:result.bytes encoding:NSUTF8StringEncoding];
    
    DataTrackPop();
    
    if(self.inputField.text.length)
        self.outputField.text = [self.outputField.text stringByAppendingFormat:@"\n\n%d rolls", (int)self.inputField.text.length];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController respondsToSelector:@selector(setPrivKey:)]) {
        
        id<TakesPriveKey> obj = segue.destinationViewController;
        
        [obj setPrivKey:self.privKey];
    }
}

@end
