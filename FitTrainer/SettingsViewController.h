//
//  SettingsViewController.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *weightPickerView;
@property (strong, nonatomic) IBOutlet UISlider *difficultyPickerView;
@property (strong, nonatomic) IBOutlet UISlider *staminaPowerPickerView;
@end
