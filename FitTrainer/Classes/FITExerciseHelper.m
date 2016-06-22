//
//  FITExerciseHelper.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITExerciseHelper.h"
#import "FITUserDefaults.h"
#import "FITWorkoutDefaults.h"
#import "FITSetHelper.h"

@implementation FITExerciseHelper


+ (id)exerciseWithDictionary:(NSDictionary *) exerciseDictionary {
    FITExerciseHelper *exercise = [[self alloc] init];
    exercise.name = exerciseDictionary[@"name"];
    exercise.info = exerciseDictionary[@"info"];
    exercise.videoURLString = exerciseDictionary[@"infoExternalLink"];
    exercise.difficulty = [exerciseDictionary[@"difficulty"] floatValue];
    exercise.weightMin = [exerciseDictionary[@"weightMin"] intValue];
    exercise.weightMax = [exerciseDictionary[@"weightMax"] intValue];
    exercise.repetitionsMin = [exerciseDictionary[@"repetitionsMin"] intValue];
    exercise.repetitionsMax = [exerciseDictionary[@"repetitionsMax"] intValue];
    exercise.image = [exercise loadImageFromURLString:exerciseDictionary[@"image"]];
    exercise.setsArray = [exercise generateSetsList];
    return exercise;
}


- (UIImage *)loadImageFromURLString:(NSString *)URLString {
    NSURL *imageURL = [NSURL URLWithString:URLString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}


- (NSArray *)generateSetsList {
    /////////////////////////////////////////////////
    // TODO: improve algorithm of set creation
    /////////////////////////////////////////////////
    FITUserDefaults *userDefaults = [FITUserDefaults instance];
    FITWorkoutDefaults *workoutDefaults = [FITWorkoutDefaults instance];
    
    //numberOfSets has linear dependence from staminaPowerRatio
    NSUInteger numberOfSets = workoutDefaults.numberOfSetsMin;
    numberOfSets += (NSUInteger)roundf((workoutDefaults.numberOfSetsMax - workoutDefaults.numberOfSetsMin) * (1 - userDefaults.staminaPowerRatio));
    self.numberOfSets = numberOfSets;
    NSMutableArray *sets = [NSMutableArray arrayWithCapacity:numberOfSets];
    
    for (NSUInteger i = 0; i < numberOfSets; i++) {
        FITSetHelper *newSet = [FITSetHelper setWithExercise:self forIndex:i];
        [sets addObject:newSet];
    }
    
    return sets;
}


@end
