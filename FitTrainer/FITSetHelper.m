//
//  FITSetHelper.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITSetHelper.h"
#import "FITUserDefaults.h"
#import "FITWorkoutDefaults.h"



@implementation FITSetHelper
static FITUserDefaults *userDefault;
static FITWorkoutDefaults *workoutDefaults;


+ (id)setWithExercise:(FITExerciseHelper *)exercise forIndex:(NSUInteger)numberOfSet {
    userDefault = [FITUserDefaults instance];
    workoutDefaults = [FITWorkoutDefaults instance];
    FITSetHelper *set = [[self alloc] init];
    set.restTimeInSeconds = [set restTime];
    set.repetitions = [set repetitionsForExercise:exercise numberOfSet:numberOfSet];
    set.weight = [set weightForExercise:exercise numberOfSet:numberOfSet];
    return set;
}


- (NSUInteger)restTime {
    CGFloat difficulty = userDefault.difficulty;
    CGFloat level = userDefault.level;
    NSUInteger maxLevel = workoutDefaults.levelMax;
    NSUInteger minTimeInSec = workoutDefaults.restingTimeMin;
    NSUInteger maxTimeInSec = workoutDefaults.restingTimeMax;
    NSUInteger restTimeInSec = minTimeInSec + (NSUInteger)roundf((maxTimeInSec - minTimeInSec) * (1 - difficulty) * (maxLevel - level) / maxLevel);
    return restTimeInSec;
}


- (NSUInteger)repetitionsForExercise:(FITExerciseHelper *)exercise numberOfSet:(NSUInteger)numberOfSet {
    NSUInteger repetitions = exercise.repetitionsMin;
    repetitions += (NSUInteger)roundf((exercise.repetitionsMax - exercise.repetitionsMin) * (1 - userDefault.staminaPowerRatio) * (0.5 + 0.5 * userDefault.difficulty));
    repetitions = (NSUInteger)roundf(repetitions * (1 - (workoutDefaults.repetitionDropRatio * numberOfSet) / exercise.numberOfSets));
    // To make at least 2 repetition
    repetitions = MAX(repetitions, 2);
    return repetitions;
}


- (NSUInteger)weightForExercise:(FITExerciseHelper *)exercise numberOfSet:(NSUInteger)numberOfSet {
    NSUInteger weight = exercise.weightMin;
    CGFloat level = userDefault.level;
    NSUInteger maxLevel = workoutDefaults.levelMax;
    CGFloat additionalWeight = (exercise.weightMax - exercise.weightMin) * (0.5 + 0.5 * userDefault.staminaPowerRatio) * (level / maxLevel);
    weight += (NSUInteger)roundf(additionalWeight);
    weight = (NSUInteger)roundf(weight * userDefault.userWeight / userDefault.userDefaultWeight);
    return weight;
}


@end

