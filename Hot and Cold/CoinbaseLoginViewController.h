//
//  CoinbaseLoginViewController.h
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-21.
//  Copyright © 2017 Ezra Kirsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinbaseLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;

@end
