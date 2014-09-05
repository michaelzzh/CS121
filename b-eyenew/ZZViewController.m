//
//  ZZViewController.m
//  bullseye
//
//  Created by Zehao Zhang on 14-9-4.
//  Copyright (c) 2014年 Zehao Zhang. All rights reserved.
//

#import "ZZViewController.h"

@interface ZZViewController ()

@end

@implementation ZZViewController

{
    int _currentValue;
    int _targetValue;
    int _score;
    int _round;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startNewRound {
    _targetValue = 1 + arc4random_uniform(100); _currentValue = 50;
    self.slider.value = _currentValue;
}

- (void)updateLabels {
    self.targetLabel.text = [NSString stringWithFormat:@"%d", _targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",_score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",_round];
}

- (IBAction)showAlert
{
    int difference = abs(_targetValue - _currentValue);
    int points = 100 - difference;
    _score += points;
    _round++;
    NSString *message = [NSString stringWithFormat: @"You scored %d points", points];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello, World!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [self startNewRound];
    [self updateLabels];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    _currentValue = lroundf(slider.value);
}
@end
