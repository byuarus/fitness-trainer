//
//  FITExercise.h
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 17.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FITUser.h"


@interface FITExercise : NSObject

@property (strong, nonatomic) NSArray *setsArray;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSUInteger numberOfSets;
@property (nonatomic) NSUInteger numberOfSetsCompleted;
@property (strong, nonatomic) NSString *youtubeVideoId;
@property (strong, nonatomic) NSString *imageURLWithString;
@property (nonatomic) NSUInteger difficulty;
@property (nonatomic) NSUInteger repetitionsMin;
@property (nonatomic) NSUInteger repetitionsMax;
@property (nonatomic) NSUInteger weightMin;
@property (nonatomic) NSUInteger weightMax;

//////  repetitionDropRatio - on what portion number of repetition will reduce
//////  e.g. if you start with 10 reps, repetitionDropRatio=0.3, than last set will have 7 rep
@property (nonatomic, readonly) CGFloat repetitionDropRatio;
@property (nonatomic, readonly) NSUInteger numberOfSetsMin;
@property (nonatomic, readonly) NSUInteger numberOfSetsMax;
@property (nonatomic, readonly) NSUInteger restingTimeMin;
@property (nonatomic, readonly) NSUInteger restingTimeMax;

+ (instancetype)exerciseWithDictionary:(NSDictionary *) exerciseDictionary;
- (void)loadDefaults:(NSDictionary*)defaultsDeictionary;

@end
