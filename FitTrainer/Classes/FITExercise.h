//
//  FITExercise.h
//  FitnessTrainer
//
//  Created by Dmitry Malakhov on 17.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITExercise : NSObject
@property (strong, nonatomic) NSArray *setsArray;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSUInteger numberOfSets;
@property (nonatomic) NSUInteger numberOfSetsCompleted;
@end
