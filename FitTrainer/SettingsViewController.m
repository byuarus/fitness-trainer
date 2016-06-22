//
//  SettingsViewController.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "SettingsViewController.h"
#import "FITUserDefaults.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
static NSMutableArray *_pickerData;
static FITUserDefaults *userDefaults;


- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [FITUserDefaults instance];
    
    [self initWeightPickerData];
    [self.difficultyPickerView setValue:userDefaults.difficulty];
    [self.staminaPowerPickerView setValue:userDefaults.staminaPowerRatio];
    self.title = @"Settings";
}


- (void)initWeightPickerData {
    _pickerData = [NSMutableArray array];
    for (NSUInteger i = 50; i < 300; i++) {
        [_pickerData addObject:[NSString stringWithFormat:@"%lu lb",(NSUInteger)i]];
    }
    self.weightPickerView.dataSource = self;
    self.weightPickerView.delegate = self;
    [self.weightPickerView selectRow:(userDefaults.userWeight-50) inComponent:0 animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)difficultyValueChanged:(id)sender {
    userDefaults.difficulty = self.difficultyPickerView.value;
}


- (IBAction)staminaPowerValueChanged:(id)sender {
    userDefaults.staminaPowerRatio = self.staminaPowerPickerView.value;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    userDefaults.userWeight = (NSUInteger)[self.weightPickerView selectedRowInComponent:0] + 50;
    [[FITUserDefaults instance] save];
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
