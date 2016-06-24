//
//  FITWorkoutViewCell.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITWorkout.h"

@interface FITWorkoutViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *workoutImageView;
@property (strong, nonatomic) IBOutlet UILabel *workoutName;
@property (strong, nonatomic) FITWorkout *workout;

@end
