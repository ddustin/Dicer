//
//  XpubSettings.m
//  Dicer
//
//  Created by Dustin Dettmer on 12/13/20.
//

#import "XpubSettings.h"

@interface XpubSettings ()

@property (weak) IBOutlet UITextField *pathField;
@property (weak) IBOutlet UITextField *passField;
@property (weak) IBOutlet UITextField *prefixField;

@end

@implementation XpubSettings

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pathField.text = self.derivationPath;
    self.passField.text = self.passphrase;
    self.prefixField.text = self.prefix;
}

- (IBAction)derivationPathChanged:(id)sender
{
    [self.delegate setDerivationPath:self.pathField.text];
}

- (IBAction)passphraseChanged:(id)sender
{
    [self.delegate setPassphrase:self.passField.text];
}

- (IBAction)prefixChanged:(id)sender
{
    [self.delegate setPrefix:self.prefixField.text];
}

- (IBAction)done:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
