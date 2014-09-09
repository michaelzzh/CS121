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

- (BOOL)prefersStatusBarHidden {
    return YES; }

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabels];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    UIImage *trackLeftImage =[[UIImage imageNamed:@"SliderTrackLeft"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
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
    
    NSString *title;
    if (difference == 0){
        title = @"Perfect";
        points += 100;
    }else if(difference < 5){
        title = @"You almost had it";
        if(difference==1){
            points += 50;
        }
    }else if(difference < 10){
        title = @"Pretty good";
    }else{
        title = @"Not even close...";
    }
    
    _score += points;
    NSString *message = [NSString stringWithFormat: @"You scored %d points", points];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

- (void)startNewGame {
    _score = 0;
    _round = 0;
    [self startNewRound];
}

- (IBAction)startOver {
    CATransition *transition = [CATransition animation]; transition.type = kCATransitionFade; transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self updateLabels];
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    _currentValue = lroundf(slider.value);
}
@end
