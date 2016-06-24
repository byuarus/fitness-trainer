//
//  FITWorkoutListCollectionViewController.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITWorkoutListCollectionViewController.h"
#import "FITWorkoutViewController.h"
#import "FITWorkoutViewCell.h"
#import "FITWorkout.h"
#import <SDWebImage/UIImageView+WebCache.h>

// TODO: change name of constant
NSString * const reuseIdentifier = @"WorkoutCell";


@interface FITWorkoutListCollectionViewController ()

@end

@implementation FITWorkoutListCollectionViewController{

NSArray *workoutList;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    workoutList = [[FITDataManager sharedInstance] workoutList];

    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];

    self.title = @"Workout Collection";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(FITWorkoutViewCell *)sender {
    if ([segue.identifier isEqualToString:@"ShowWorkout"]) {
        FITWorkoutViewController *destViewController = segue.destinationViewController;
        destViewController.typeOfWorkout = sender.workout.typeOfWorkout;
    }

}


// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGSize mElementSize = CGSizeMake((width-20)/2, 180);
    return mElementSize;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


// Layout: Set Edges
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10,8,0,8);  // top, left, bottom, right
}


#pragma mark <UICollectionViewDataSource>
- (void)configureCell:(FITWorkoutViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    FITWorkout *workout = [FITWorkout newWorkoutOfType:(NSUInteger)indexPath.item];
    cell.workoutName.text = workout.name;
    [cell.workoutImageView sd_setImageWithURL:[NSURL URLWithString:workout.imageURLWithString]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.workout = workout;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return workoutList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FITWorkoutViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}


@end
