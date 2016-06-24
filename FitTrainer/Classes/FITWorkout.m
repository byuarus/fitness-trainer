//
//  FITWorkout.m
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 17.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITWorkout.h"
#import "FITDataManager.h"

@interface FITWorkout ()

@property (nonatomic, retain) NSDictionary *workoutDefaults;

@end

@implementation FITWorkout


+ (instancetype)newWorkoutOfType:(NSUInteger)typeOfWorkout {
    FITWorkout *newWorkout = [[self alloc] init];
    [newWorkout loadWorkoutDefaultsForWorkoutType:typeOfWorkout];
    newWorkout.typeOfWorkout = typeOfWorkout;
    newWorkout.info = newWorkout.workoutDefaults[@"info"];
    newWorkout.name = newWorkout.workoutDefaults[@"name"];
    newWorkout.userWeight = FITUser.weight;
    newWorkout.difficulty = FITUser.difficulty;
    newWorkout.staminaPowerRatio = FITUser.staminaPowerRatio;
    newWorkout.level = FITUser.level;
    newWorkout.imageURLWithString = newWorkout.workoutDefaults[@"image"];
    newWorkout.exerciseList = [newWorkout generateExerciseList];
    return newWorkout;
}


- (void)loadWorkoutDefaultsForWorkoutType:(NSUInteger)typeOfWorkout {
    NSArray *workoutList = [[FITDataManager sharedInstance] workoutList];
    self.workoutDefaults = workoutList[typeOfWorkout];
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
    NSArray *exerciseList = self.workoutDefaults[@"exercises"];
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
