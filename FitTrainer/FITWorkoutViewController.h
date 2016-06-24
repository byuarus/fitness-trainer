//
//  FITWorkoutViewController.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITWorkoutViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSUInteger typeOfWorkout;

@end
