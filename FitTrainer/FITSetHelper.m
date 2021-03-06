//
//  FITSetHelper.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITSetHelper.h"
#import "FITUser.h"
#import "FITWorkoutDefaults.h"



@implementation FITSetHelper{

FITUser *userDefault;
FITWorkoutDefaults *workoutDefaults;

}

+ (instancetype)setWithExercise:(FITExercise *)exercise forIndex:(NSUInteger)numberOfSet {
    FITSetHelper *set = [[self alloc] init];
    set.restTimeInSeconds = [set restTime];
    set.repetitions = [set repetitionsForExercise:exercise numberOfSet:numberOfSet];
    set.weight = [set weightForExercise:exercise numberOfSet:numberOfSet];
    return set;
}


- (NSUInteger)restTime {
    CGFloat difficulty = FITUser.difficulty;
    CGFloat level = FITUser.level;
    NSUInteger maxLevel = workoutDefaults.levelMax;
    NSUInteger minTimeInSec = workoutDefaults.restingTimeMin;
    NSUInteger maxTimeInSec = workoutDefaults.restingTimeMax;
    NSUInteger restTimeInSec = minTimeInSec + (NSUInteger)roundf((maxTimeInSec - minTimeInSec) * (1 - difficulty) * (maxLevel - level) / maxLevel);
    return restTimeInSec;
}


- (NSUInteger)repetitionsForExercise:(FITExercise *)exercise numberOfSet:(NSUInteger)numberOfSet {
    NSUInteger repetitions = exercise.repetitionsMin;
    repetitions += (NSUInteger)roundf((exercise.repetitionsMax - exercise.repetitionsMin) * (1 - FITUser.staminaPowerRatio) * (0.5 + 0.5 * FITUser.difficulty));
    repetitions = (NSUInteger)roundf(repetitions * (1 - (workoutDefaults.repetitionDropRatio * numberOfSet) / exercise.numberOfSets));
    // To make at least 2 repetition
    repetitions = MAX(repetitions, 2);
    return repetitions;
}


- (NSUInteger)weightForExercise:(FITExercise *)exercise numberOfSet:(NSUInteger)numberOfSet {
    NSUInteger weight = exercise.weightMin;
    CGFloat level = FITUser.level;
    NSUInteger maxLevel = workoutDefaults.levelMax;
    CGFloat additionalWeight = (exercise.weightMax - exercise.weightMin) * (0.5 + 0.5 * FITUser.staminaPowerRatio) * (level / maxLevel);
    weight += (NSUInteger)roundf(additionalWeight);
    weight = (NSUInteger)roundf(weight * FITUser.weight / FITUser.defaultWeight);
    return weight;
}


@end

