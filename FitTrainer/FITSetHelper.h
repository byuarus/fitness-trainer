//
//  FITSetHelper.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITSet.h"
#import "FITExerciseHelper.h"

@interface FITSetHelper : FITSet
+ (id)setWithExercise:(FITExerciseHelper *)exercise forIndex:(NSUInteger)numberOfSet;
@end
