//
//  FITSettingsViewController.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITSettingsViewController.h"
#import "FITUser.h"

@interface FITSettingsViewController ()

@end

@implementation FITSettingsViewController{

NSMutableArray *_pickerData;
FITUser *userDefaults;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWeightPickerData];
    [self.difficultyPickerView setValue:FITUser.difficulty];
    [self.staminaPowerPickerView setValue:FITUser.staminaPowerRatio];
    self.title = @"Settings";
}


- (void)initWeightPickerData {
    _pickerData = [NSMutableArray array];
    for (NSUInteger i = 50; i < 300; i++) {
        [_pickerData addObject:[NSString stringWithFormat:@"%lu lb",(unsigned long)i]];
    }
    self.weightPickerView.dataSource = self;
    self.weightPickerView.delegate = self;
    [self.weightPickerView selectRow:(FITUser.weight-50) inComponent:0 animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)difficultyValueChanged:(id)sender {
    FITUser.difficulty = self.difficultyPickerView.value;
}


- (IBAction)staminaPowerValueChanged:(id)sender {
    FITUser.staminaPowerRatio = self.staminaPowerPickerView.value;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    FITUser.weight = (NSUInteger)[self.weightPickerView selectedRowInComponent:0] + 50;
    [FITUser  save];
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}


// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

@end
