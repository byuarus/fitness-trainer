//
//  WorkoutListCollectionViewController.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "WorkoutListCollectionViewController.h"
#import "WorkoutViewController.h"
#import "WorkoutViewCell.h"
#import "FITWorkoutHelper.h"

@interface WorkoutListCollectionViewController ()

@end

@implementation WorkoutListCollectionViewController

static NSString * const reuseIdentifier = @"WorkoutCell";
static NSArray *workoutList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    workoutList = [[FITWorkoutDataManager instance] workoutList];

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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(WorkoutViewCell *)sender {
    if ([segue.identifier isEqualToString:@"ShowWorkout"]) {
        WorkoutViewController *destViewController = segue.destinationViewController;
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
- (void)configureCell:(WorkoutViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    FITWorkoutHelper *workout = [FITWorkoutHelper newWorkoutOfType:(NSUInteger)indexPath.item];
    cell.workoutName.text = workout.name;
    cell.workoutImageView.image = workout.image;
    cell.workout = workout;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return workoutList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}


@end
