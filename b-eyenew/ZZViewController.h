//
//  ZZViewController.h
//  bullseye
//
//  Created by Zehao Zhang on 14-9-4.
//  Copyright (c) 2014年 Zehao Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UISlider *slider;

@property (nonatomic, weak) IBOutlet UILabel *targetLabel;

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

@property (nonatomic, weak) IBOutlet UILabel *roundLabel;

-(IBAction)showAlert;

-(IBAction)startOver;

- (IBAction)sliderMoved:(UISlider *)slider;

@end
