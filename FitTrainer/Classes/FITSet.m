//
//  FITSet.m
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITSet.h"
#import "Defaults.h"
#import "FITExercise.h"

@implementation FITSet


+ (instancetype)setWithExercise:(FITExercise *)exercise forIndex:(NSUInteger)numberOfSet {
    FITSet *set = [[self alloc] init];
    set.restTimeInSeconds = [set restTime];
    set.repetitions = [set repetitionsForExercise:exercise numberOfSet:numberOfSet];
    set.weight = [set weightForExercise:exercise numberOfSet:numberOfSet];
    set.exercise = exercise;
    return set;
}


- (NSUInteger)restTime {
    CGFloat difficulty = FITUser.difficulty;
    CGFloat level = FITUser.level;
    NSUInteger minTimeInSec = self.exercise.restingTimeMin;
    NSUInteger maxTimeInSec = self.exercise.restingTimeMax;
    NSUInteger restTimeInSec = minTimeInSec + (NSUInteger)roundf((maxTimeInSec - minTimeInSec) * (1 - difficulty) * (MAX_LEVEL - level) / MAX_LEVEL);
    return restTimeInSec;
}


- (NSUInteger)repetitionsForExercise:(FITExercise *)exercise numberOfSet:(NSUInteger)numberOfSet {
    NSUInteger repetitions = exercise.repetitionsMin;
    repetitions += (NSUInteger)roundf((exercise.repetitionsMax - exercise.repetitionsMin) * (1 - FITUser.staminaPowerRatio) * (0.5 + 0.5 * FITUser.difficulty));
    repetitions = (NSUInteger)roundf(repetitions * (1 - (self.exercise.repetitionDropRatio * numberOfSet) / exercise.numberOfSets));
    // To make at least 2 repetition
    repetitions = MAX(repetitions, 2);
    return repetitions;
}


- (NSUInteger)weightForExercise:(FITExercise *)exercise numberOfSet:(NSUInteger)numberOfSet {
    NSUInteger weight = exercise.weightMin;
    CGFloat level = FITUser.level;
    CGFloat additionalWeight = (exercise.weightMax - exercise.weightMin) * (0.5 + 0.5 * FITUser.staminaPowerRatio) * (level / MAX_LEVEL);
    weight += (NSUInteger)roundf(additionalWeight);
    weight = (NSUInteger)roundf(weight * FITUser.weight / FITUser.defaultWeight);
    return weight;
}



@end
