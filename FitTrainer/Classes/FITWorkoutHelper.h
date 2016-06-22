//
//  FITWorkoutHelper.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITWorkout.h"
#import <UIKit/UIKit.h>

@interface FITWorkoutHelper : FITWorkout
@property (strong, nonatomic) UIImage *image;

+ (id)newWorkoutOfType:(NSUInteger)typeOfWorkout;
@end
