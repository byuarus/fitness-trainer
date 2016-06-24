//
//  FITSetHelper.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITSet.h"
#import "FITExercise.h"
@class FITExercise;
@class FITSet;

@interface FITSetHelper : FITSet

+ (instancetype)setWithExercise:(FITExercise *)exercise forIndex:(NSUInteger)numberOfSet;

@end
