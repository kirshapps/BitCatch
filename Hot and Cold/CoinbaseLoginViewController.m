//
//  CoinbaseLoginViewController.m
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-21.
//  Copyright © 2017 Ezra Kirsh. All rights reserved.
//

#import "CoinbaseLoginViewController.h"

@interface CoinbaseLoginViewController ()

@end

@implementation CoinbaseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)login:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_email.text forKey:@"email"];
    [userDefaults setObject:_password.text forKey:@"password"];
    [self performSegueWithIdentifier:@"startMainGame" sender:nil];
}

@end
