//
//  CountdownViewController.m
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import "CountdownViewController.h"

@interface CountdownViewController ()

@end

@implementation CountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
selector:@selector(handleReceivedDataWithNotification:)
name:@"MPCDemo_DidReceiveDataNotification"
object:nil];
    currentNumber = 30;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timeDown {
    currentNumber -= 1;
    _countdonLabel.text = [NSString stringWithFormat:@"%i", currentNumber];
    if (currentNumber <= 0) {
        [timer invalidate];
        [self startGame];
    }
}

- (void)handleReceivedDataWithNotification:(NSNotification *)notification {
    NSDictionary *userInfoDict = [notification userInfo];
    NSData *messageData = [userInfoDict objectForKey:@"data"];
    NSString *message = [[NSString alloc] initWithData:messageData encoding:NSUTF8StringEncoding];
    
    self.uuid = message;
    NSLog(@"%@", message);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:message forKey:@"uuid"];
    [self startGame];
}

- (void)startGame {
    [self performSegueWithIdentifier:@"startGame" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
