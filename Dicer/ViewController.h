//
//  ViewController.h
//  Dicer
//
//  Created by Dustin Dettmer on 12/12/20.
//

#import <UIKit/UIKit.h>

@protocol TakesPriveKey <NSObject>

- (void)setPrivKey:(NSData*)privKey;

@end

@interface ViewController : UIViewController<UITextFieldDelegate>


@end

