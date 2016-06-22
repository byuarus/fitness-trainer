//
//  FITWorkoutDefaults.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITWorkoutDefaults.h"

@implementation FITWorkoutDefaults
+ (id)instance {
    static FITWorkoutDefaults *instanceWorkoutDefaults = nil;
    @synchronized(self) {
        if (instanceWorkoutDefaults == nil)
            instanceWorkoutDefaults = [[self alloc] init];
    }
    return instanceWorkoutDefaults;
}


- (id)init {
    if (self = [super init]) {

    }
    return self;
}


- (void)updateWithDictionary:(NSDictionary *)defaultsDictionary {
    self.levelMax = [defaultsDictionary[@"levelMax"] intValue];
    self.restingTimeMin = [defaultsDictionary[@"restingTimeMin"] intValue];
    self.restingTimeMax = [defaultsDictionary[@"restingTimeMax"] intValue];
    self.numberOfSetsMax = [defaultsDictionary[@"numberOfSetsMax"] intValue];
    self.numberOfSetsMin = [defaultsDictionary[@"numberOfSetsMin"] intValue];
    self.repetitionDropRatio = [defaultsDictionary[@"repetitionDropRatio"] floatValue];
}


@end
