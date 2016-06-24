//
//  FITWorkout.h
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 17.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITExercise.h"
#import <UIKit/UIKit.h>

@interface FITWorkout : NSObject

@property (nonatomic) NSUInteger typeOfWorkout;
@property (nonatomic) CGFloat difficulty;
@property (nonatomic) NSUInteger userWeight;
@property (nonatomic) CGFloat staminaPowerRatio;
@property (nonatomic) NSUInteger level;
@property (nonatomic, getter=isDayStarted) BOOL dayStarted;
@property (nonatomic, getter=isDayFinished) BOOL dayFinished;
@property (strong, nonatomic) NSArray *exerciseList;
@property (strong, nonatomic) NSDate *dateTimeStarted;
@property (strong, nonatomic) NSDate *dateTimeFinished;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURLWithString;

+ (instancetype)newWorkoutOfType:(NSUInteger)typeOfWorkout;

@end

