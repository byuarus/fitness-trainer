//
//  FITWorkoutHelper.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//


////////////////////////////////////////////////
//  In this file we will create new workout using information about:
//    1) type of workout that user have chosen
//    2) list of available exercises
//    3) user info (staminaPowerRatio, level, userWeight)
////////////////////////////////////////////////

#import "FITWorkoutHelper.h"
#import "FITDataManager.h"
#import "FITExercise.h"
#import "FITUser.h"

@implementation FITWorkoutHelper

NSDictionary *workoutDefaults;


+ (instancetype)newWorkoutOfType:(NSUInteger)typeOfWorkout {
//    FITUser *userDefaults = [FITUser instance];
    FITWorkoutHelper *newWorkout = [[self alloc] init];
    [newWorkout loadWorkoutDefaultsForWorkoutType:typeOfWorkout];
    newWorkout.typeOfWorkout = typeOfWorkout;
    newWorkout.info = workoutDefaults[@"info"];
    newWorkout.name = workoutDefaults[@"name"];
    newWorkout.userWeight = FITUser.weight;
    newWorkout.difficulty = FITUser.difficulty;
    newWorkout.staminaPowerRatio = FITUser.staminaPowerRatio;
    newWorkout.level = FITUser.level;
    newWorkout.image = [newWorkout loadImageFromURLString:workoutDefaults[@"image"]];
    newWorkout.exerciseList = [newWorkout generateExerciseList];
    return newWorkout;
}


- (void)loadWorkoutDefaultsForWorkoutType:(NSUInteger)typeOfWorkout {
    NSArray *workoutList = [[FITDataManager instance] workoutList];
    workoutDefaults = workoutList[typeOfWorkout];
}


- (NSArray *)generateExerciseList {
    /////////////////////////////////////////////////
    // TODO: improve algorithm of exercise selection
    /////////////////////////////////////////////////
    NSArray *availableExercises = [self availableExerciseList];
    NSMutableArray *selectedExercisesList = [NSMutableArray array];
    
    for (FITExercise *exercise in availableExercises) {
        if (exercise.difficulty <= self.difficulty) {
            [selectedExercisesList addObject:exercise];
        }
    }
    
    return selectedExercisesList;
}


- (NSArray *)availableExerciseList {
    NSArray *exerciseList = workoutDefaults[@"exercises"];
    NSMutableArray *exerciseArray = [NSMutableArray arrayWithCapacity:exerciseList.count];
    
    for (int i = 0; i < exerciseList.count; i++) {
        NSDictionary *exerciseDictionary = (NSDictionary *)exerciseList[i];
        FITExercise *exercise = [FITExercise exerciseWithDictionary:exerciseDictionary];
        [exerciseArray addObject:exercise];
    }
    
    return exerciseArray;
}


-(UIImage *)loadImageFromURLString:(NSString *)URLString {
    NSURL *imageURL = [NSURL URLWithString:URLString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}
@end

