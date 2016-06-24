//
//  FITUser.m
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITUser.h"

@implementation FITUser

static NSUInteger weight;
static const NSUInteger defaultWeight = 150;
static CGFloat difficulty;
static CGFloat staminaPowerRatio;
static NSUInteger level;


+ (void)load {
    // Load the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userWeightString = [defaults objectForKey:@"userWeight"];
    
    if (userWeightString) {
        weight = [userWeightString intValue];
    } else {
        weight = defaultWeight;
    }
    
    NSString *levelString = [defaults objectForKey:@"level"];
    
    if (levelString) {
        level = [levelString intValue];
    } else {
        level = 1;
    }
    
    NSString *difficultyString = [defaults objectForKey:@"difficulty"];
    
    if (difficultyString) {
        difficulty = [difficultyString floatValue];
    } else {
        difficulty = 0.5;
    }
    
    NSString *staminaPowerRatioString = [defaults objectForKey:@"staminaPowerRatio"];
    
    if (staminaPowerRatioString) {
        staminaPowerRatio = [staminaPowerRatioString floatValue];
    }  else {
        staminaPowerRatio = 0.5;
    }
}


+ (NSUInteger)weight {
    return weight;
}


+ (void)setWeight:(NSUInteger)value {
    weight = value;
}


+ (NSUInteger)defaultWeight {
    return defaultWeight;
}


+ (CGFloat)difficulty {
    return difficulty;
}


+ (void)setDifficulty:(CGFloat)value {
    difficulty = value;
}


+ (CGFloat)staminaPowerRatio {
    return staminaPowerRatio;
}


+ (void)setStaminaPowerRatio:(CGFloat)value {
    staminaPowerRatio = value;
}


+ (NSUInteger)level {
    return level;
}


+ (void)setLevel:(NSUInteger)value {
    level = value;
}


+ (void)save {
    // Save the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:weight forKey:@"userWeight"];
    [defaults setFloat:difficulty forKey:@"difficulty"];
    [defaults setFloat:staminaPowerRatio forKey:@"staminaPowerRatio"];
    [defaults setInteger:level forKey:@"level"];
    [defaults synchronize];
}


@end
