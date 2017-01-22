//
//  PlayerSetupViewController.m
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import "PlayerSetupViewController.h"

@interface PlayerSetupViewController ()

@end

@implementation PlayerSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    labelArray = [NSMutableArray array];
    [labelArray addObject:_playerLabel1];
    [labelArray addObject:_playerLabel2];
    [labelArray addObject:_playerLabel3];
    [labelArray addObject:_playerLabel4];
    [labelArray addObject:_playerLabel5];
    [labelArray addObject:_playerLabel6];
    [labelArray addObject:_playerLabel7];
    peersConnected = 0;
    for (int y = 0; y < labelArray.count; y++) {
        UILabel *label = labelArray[y];
        label.hidden = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerChangedStateWithNotification:)
                                                 name:@"MPCDemo_DidChangeStateNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleReceivedDataWithNotification:)
                                                 name:@"MPCDemo_DidReceiveDataNotification"
                                               object:nil];
    

}

- (void)peerChangedStateWithNotification:(NSNotification *)notification {
    int state = [[notification userInfo] objectForKey:@"state"];
    NSString *peerID = [[[notification userInfo] objectForKey:@"peerID"] displayName];
    if (state != MCSessionStateConnecting) {
        UILabel *currentLabel = labelArray[peersConnected];
        currentLabel.hidden = NO;
        currentLabel.text = [NSString stringWithFormat:@"%@ joined the game", peerID];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleReceivedDataWithNotification:(NSNotification *)notification {
    NSDictionary *userInfoDict = [notification userInfo];
    NSData *messageData = [userInfoDict objectForKey:@"data"];
    NSString *message = [[NSString alloc] initWithData:messageData encoding:NSUTF8StringEncoding];
    
    if ([message isEqualToString:@"New Game"]) {
        [self performSegueWithIdentifier:@"playerCountdown" sender:self];
    }
   

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
