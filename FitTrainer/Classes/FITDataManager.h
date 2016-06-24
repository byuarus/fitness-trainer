//
//  FITDataManager.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITDataManager : NSObject

@property (strong,nonatomic) NSArray *workoutList;

+ (instancetype)sharedInstance;

@end
