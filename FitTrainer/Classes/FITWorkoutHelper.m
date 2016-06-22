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
#import "FITWorkoutDataManager.h"
#import "FITExerciseHelper.h"
#import "FITUserDefaults.h"

@implementation FITWorkoutHelper

NSDictionary *workoutDefaults;


+ (id)newWorkoutOfType:(NSUInteger)typeOfWorkout {
    FITUserDefaults *userDefaults = [FITUserDefaults instance];
    FITWorkoutHelper *newWorkout = [[self alloc] init];
    [newWorkout loadWorkoutDefaultsForWorkoutType:typeOfWorkout];
    newWorkout.typeOfWorkout = typeOfWorkout;
    newWorkout.info = workoutDefaults[@"info"];
    newWorkout.name = workoutDefaults[@"name"];
    newWorkout.userWeight = userDefaults.userWeight;
    newWorkout.difficulty = userDefaults.difficulty;
    newWorkout.staminaPowerRatio = userDefaults.staminaPowerRatio;
    newWorkout.level = userDefaults.level;
    newWorkout.image = [newWorkout loadImageFromURLString:workoutDefaults[@"image"]];
    newWorkout.exerciseList = [newWorkout generateExerciseList];
    return newWorkout;
}


- (void)loadWorkoutDefaultsForWorkoutType:(NSUInteger)typeOfWorkout {
    NSArray *workoutList = [[FITWorkoutDataManager instance] workoutList];
    workoutDefaults = workoutList[typeOfWorkout];
}


- (NSArray *)generateExerciseList {
    /////////////////////////////////////////////////
    // TODO: improve algorithm of exercise selection
    /////////////////////////////////////////////////
    NSArray *availableExercises = [self availableExerciseList];
    NSMutableArray *selectedExercisesList = [NSMutableArray array];
    
    for (FITExerciseHelper *exercise in availableExercises) {
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
        FITExerciseHelper *exercise = [FITExerciseHelper exerciseWithDictionary:exerciseDictionary];
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

