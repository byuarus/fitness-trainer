//
//  FITExercise.m
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 17.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITExercise.h"
#import "FITSet.h"


@implementation FITExercise


+ (instancetype)exerciseWithDictionary:(NSDictionary *) exerciseDictionary {
    FITExercise *exercise = [[self alloc] init];
    exercise.name = exerciseDictionary[@"name"];
    exercise.info = exerciseDictionary[@"info"];
    exercise.youtubeVideoId = exerciseDictionary[@"youtubeVideoId"];
    exercise.difficulty = [exerciseDictionary[@"difficulty"] floatValue];
    exercise.weightMin = [exerciseDictionary[@"weightMin"] intValue];
    exercise.weightMax = [exerciseDictionary[@"weightMax"] intValue];
    exercise.repetitionsMin = [exerciseDictionary[@"repetitionsMin"] intValue];
    exercise.repetitionsMax = [exerciseDictionary[@"repetitionsMax"] intValue];
    exercise.imageURLWithString = exerciseDictionary[@"image"];
    [exercise loadDefaults:exerciseDictionary];
    exercise.setsArray = [exercise generateSetList];
    return exercise;
}



- (void)loadDefaults:(NSDictionary *)defaultsDictionary {
    _restingTimeMin = [defaultsDictionary[@"restingTimeMin"] intValue];
    _restingTimeMax = [defaultsDictionary[@"restingTimeMax"] intValue];
    _numberOfSetsMax = [defaultsDictionary[@"numberOfSetsMax"] intValue];
    _numberOfSetsMin = [defaultsDictionary[@"numberOfSetsMin"] intValue];
    _repetitionDropRatio = [defaultsDictionary[@"repetitionDropRatio"] floatValue];
}



- (UIImage *)loadImageFromURLString:(NSString *)URLString {
    NSURL *imageURL = [NSURL URLWithString:URLString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    return [UIImage imageWithData:imageData];
}


- (NSArray *)generateSetList {
    /////////////////////////////////////////////////
    // TODO: improve algorithm of set creation
    /////////////////////////////////////////////////
    //    FITUser *userDefaults = [FITUser instance];
//    FITWorkoutDefaults *workoutDefaults = [FITWorkoutDefaults instance];
    
    //numberOfSets has linear dependence from staminaPowerRatio
    NSUInteger numberOfSets = self.numberOfSetsMin;
    numberOfSets += (NSUInteger)roundf((self.numberOfSetsMax - self.numberOfSetsMin) * (1 - FITUser.staminaPowerRatio));
    self.numberOfSets = numberOfSets;
    NSMutableArray *sets = [NSMutableArray arrayWithCapacity:numberOfSets];
    
    for (NSUInteger i = 0; i < numberOfSets; i++) {
        FITSet *newSet = [FITSet setWithExercise:self forIndex:i];
        [sets addObject:newSet];
    }
    
    return sets;
}


@end
