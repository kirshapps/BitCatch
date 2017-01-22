//
//  HostSetupViewController.m
//  Hot and Cold
//
//  Created by Ezra Kirsh on 2017-01-22.
//  Copyright (c) 2017 Ezra Kirsh. All rights reserved.
//

#import "HostSetupViewController.h"

@interface HostSetupViewController ()

@end

@implementation HostSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    labelArray = [NSMutableArray array];
    [labelArray addObject:_userAdd1];
    [labelArray addObject:_userAdd2];
    [labelArray addObject:_userAdd3];
    [labelArray addObject:_userAdd4];
    [labelArray addObject:_userAdd7];
    [labelArray addObject:_userAdd5];
    [labelArray addObject:_userAdd6];
    
    for (int y = 0; y < labelArray.count; y++) {
        UILabel *label = labelArray[y];
        label.hidden = YES;
    }
    
    _startGame.layer.cornerRadius = 20;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerChangedStateWithNotification:)
                                                 name:@"MPCDemo_DidChangeStateNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerReceivedDataWithNotification:)
                                                 name:@"MPCDemo_DidReceiveDataNotification"
                                               object:nil];
    
    for (int x = 0; x < self.appDelegate.mpcHandler.session.connectedPeers.count; x++) {
        MCPeerID *peer = self.appDelegate.mpcHandler.session.connectedPeers[x];
        UILabel *label = labelArray[x];
        label.hidden = NO;
        [labelArray[x] setText:[NSString stringWithFormat:@"%@ joined your game", peer.displayName]];
    }
}

- (void)peerChangedStateWithNotification:(NSNotification *)notification {
    
}

- (void)peerReceivedDataWithNotification:(NSNotification *)notification {
    NSDictionary *userInfoDict = [notification userInfo];
    NSData *messageData = [userInfoDict objectForKey:@"data"];
    NSString *message = [[NSString alloc] initWithData:messageData encoding:NSUTF8StringEncoding];
    NSLog(@"Message: %@", message);
    if ([message  isEqual: @"lost"]) {
        [self performSegueWithIdentifier:@"hostLost" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"hostWon" sender:self];
    }
}

- (IBAction)startGame:(id)sender {
    NSString *status = @"New Game";
    NSData *data = [status dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    [self.appDelegate.mpcHandler.session sendData:data toPeers:self.appDelegate.mpcHandler.session.connectedPeers withMode:MCSessionSendDataReliable error:&error];
    if (error == nil) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Hide your device" message:@"Find a good hiding spot, and click 'Done' when you are done" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIScreen *screen = [UIScreen mainScreen];
            screen.brightness = 0.0;
            [self setupBeacon];
        }];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBeacon {
    NSUUID *uuid = [NSUUID UUID];
    NSString *string = uuid.UUIDString;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    [self.appDelegate.mpcHandler.session sendData:data toPeers:self.appDelegate.mpcHandler.session.connectedPeers withMode:MCSessionSendDataReliable error:&error];
    self.myBeaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:1 minor:1 identifier:@"com.kirshapps.warmerandcolder"];
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        [self.peripheralManager startAdvertising:self.myBeaconData];
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
