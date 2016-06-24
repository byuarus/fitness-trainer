//
//  FITSet.h
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FITWorkout.h"
@class FITExercise;

@interface FITSet : NSObject

@property (nonatomic) NSUInteger weight;
@property (nonatomic) NSUInteger repetitions;
@property (nonatomic) NSTimeInterval restTimeInSeconds;
@property (nonatomic, getter=isComplete) BOOL complete;
@property (strong, nonatomic) NSDate *setTimeStarted;
@property (strong, nonatomic) NSDate *setTimeFinnished;
@property (strong, nonatomic) FITExercise *exercise;

+ (instancetype)setWithExercise:(FITExercise *)exercise forIndex:(NSUInteger)numberOfSet;

@end
