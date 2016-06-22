//
//  FITUserDefaults.m
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITUserDefaults.h"

@implementation FITUserDefaults


+ (id)instance {
    static FITUserDefaults *userDefaults = nil;
    @synchronized(self) {
        if (userDefaults == nil)
            userDefaults = [[self alloc] init];
    }
    return userDefaults;
}


- (id)init {
    if (self = [super init]) {
        self.userDefaultWeight = 150;
        [self load];
    }
    
    return self;
}


- (void)save {
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.userWeight forKey:@"userWeight"];
    [defaults setFloat:self.difficulty forKey:@"difficulty"];
    [defaults setFloat:self.staminaPowerRatio forKey:@"staminaPowerRatio"];
    [defaults setInteger:self.level forKey:@"level"];
    [defaults synchronize];
}


- (void)load {
    // Load the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userWeightString = [defaults objectForKey:@"userWeight"];
    
    if (userWeightString) {
        self.userWeight = [userWeightString intValue];
    } else {
        self.userWeight = self.userDefaultWeight;
    }
    
    NSString *levelString = [defaults objectForKey:@"level"];
    
    if (levelString) {
        self.level = [levelString intValue];
    } else {
        self.level = 1;
    }
    
    NSString *difficultyString = [defaults objectForKey:@"difficulty"];
    
    if (difficultyString) {
        self.difficulty = [difficultyString floatValue];
    } else {
        self.difficulty = 0.5;
    }
    
    NSString *staminaPowerRatioString = [defaults objectForKey:@"staminaPowerRatio"];
    
    if (staminaPowerRatioString) {
        self.staminaPowerRatio = [staminaPowerRatioString floatValue];
    }  else {
        self.staminaPowerRatio = 0.5;
    }
}


@end
