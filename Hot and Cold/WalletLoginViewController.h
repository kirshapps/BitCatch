//
//  WalletLoginViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-21.
//  Copyright © 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *login;
- (IBAction)loginClicked:(id)sender;

@end
