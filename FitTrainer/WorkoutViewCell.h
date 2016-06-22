//
//  WorkoutViewCell.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITWorkoutHelper.h"

@interface WorkoutViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *workoutImageView;
@property (strong, nonatomic) IBOutlet UILabel *workoutName;
@property (strong, nonatomic) FITWorkoutHelper *workout;
@end
