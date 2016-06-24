//
//  FITUser.h
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FITUser : NSObject

////measuring in lb. default 150lb
+ (NSUInteger)weight;
+ (void) setWeight:(NSUInteger)value;
+ (NSUInteger)defaultWeight;
////difficulty is 0..1 (from easy to hard)
+ (CGFloat)difficulty;
+ (void) setDifficulty:(CGFloat)value;
////staminaPowerRatio 0..1. If 0 than we train our stamina, if 1 we tran power
+ (CGFloat)staminaPowerRatio;
+ (void) setStaminaPowerRatio:(CGFloat)value;
////Level shows how cool you are. It grows with completed workouts and drops if you don't do workouts more than X days
+ (NSUInteger)level;
+ (void) setLevel:(NSUInteger)value;
+ (void) save;

@end
