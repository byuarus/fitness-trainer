//
//  FITExercise.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITExercise.h"
#import <UIKit/UIKit.h>

@interface FITExercise : FITExercise

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *videoURLString;
@property (nonatomic) NSUInteger difficulty;
@property (nonatomic) NSUInteger repetitionsMin;
@property (nonatomic) NSUInteger repetitionsMax;
@property (nonatomic) NSUInteger weightMin;
@property (nonatomic) NSUInteger weightMax;

+ (instancetype)exerciseWithDictionary:(NSDictionary *) exerciseDictionary;

@end