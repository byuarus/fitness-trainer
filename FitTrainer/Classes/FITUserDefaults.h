//
//  FITUserDefaults.h
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FITUserDefaults : NSObject
//measuring in lb. default 150lb
@property (nonatomic) NSUInteger userWeight;
@property (nonatomic) NSUInteger const userDefaultWeight;
//difficulty is 0..1 (from easy to hard)
@property (nonatomic) CGFloat difficulty;
//staminaPowerRatio 0..1. If 0 than we train our stamina, if 1 we tran power
@property (nonatomic) CGFloat staminaPowerRatio;
//Level shows how cool you are. It grows with completed workouts and drops if you don't do workouts more than X days
@property (nonatomic) NSUInteger level;
+ (id)instance;
- (void) save;
@end
