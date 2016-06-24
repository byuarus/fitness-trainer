//
//  FITExerciseHeaderView.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITExerciseHeaderView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *exerciseName;
@property (strong, nonatomic) IBOutlet UIButton *exerciseInfoButton;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
