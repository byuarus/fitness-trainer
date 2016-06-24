//
//  FITWorkoutDefaults.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//


/////////////////////////////////
// Workout defaults are loads from WorkoutTemplate.json file
// and updates from server
/////////////////////////////////

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FITWorkoutDefaults : NSObject

@property (nonatomic) NSUInteger levelMax;
@property (nonatomic) NSUInteger numberOfSetsMin;
@property (nonatomic) NSUInteger numberOfSetsMax;
@property (nonatomic) NSUInteger restingTimeMin;
@property (nonatomic) NSUInteger restingTimeMax;
//  repetitionDropRatio - on what portion number of repetition will reduce
//  e.g. if you start with 10 reps, repetitionDropRatio=0.3, than last set will have 7 rep
@property (nonatomic) CGFloat repetitionDropRatio;

+ (instancetype)instance;
- (void)updateWithDictionary:(NSDictionary *)defaultsDictionary;

@end
