//
//  WorkoutViewController.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "WorkoutViewController.h"
#import "FITWorkoutHelper.h"
#import "FITExerciseHelper.h"
#import "FITSetHelper.h"
#import "SetCell.h"
#import "ExerciseHeaderView.h"
#import "ExerciseInfoViewController.h"

@interface WorkoutViewController ()
@property (nonatomic, strong) NSArray *exerciseList;
@property (nonatomic, strong) FITWorkoutHelper *workout;
@end

@implementation WorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.workout = [FITWorkoutHelper newWorkoutOfType:self.typeOfWorkout];
    self.exerciseList = [self.workout exerciseList];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    self.collectionView.allowsMultipleSelection = YES;
    
    self.title = [NSString stringWithFormat:@"%@  L-%lu",self.workout.name,(unsigned long)self.workout.level];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>
- (void)configureCell:(SetCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    FITExerciseHelper *exercise = self.exerciseList[indexPath.section];
    FITSetHelper *set = exercise.setsArray[indexPath.item];
    cell.weight.text = [NSString stringWithFormat:@"%lu lb",(unsigned long)set.weight];
    cell.weight.textAlignment = NSTextAlignmentCenter;
    cell.repetitions.text = [NSString stringWithFormat:@"%lu reps",(unsigned long)set.repetitions];
    cell.repetitions.textAlignment = NSTextAlignmentCenter;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:119.0/255 green:217.0/255 blue:77.0/255 alpha:255];
    cell.selected = set.isComplete;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.exerciseList.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Set Cell" forIndexPath:indexPath];
    cell.isComplete = !cell.isComplete;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    FITExerciseHelper *exercise = self.exerciseList[section];
    return exercise.setsArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Set Cell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}


- (void)configureHeader:(ExerciseHeaderView *)header forIndexPath:(NSIndexPath *)indexPath {
    FITExerciseHelper* exercise = self.exerciseList[indexPath.section];
    header.exerciseName.text = [[NSString stringWithFormat:@" %@",exercise.name] capitalizedString];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        ExerciseHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [self configureHeader:headerView forIndexPath:indexPath];
        headerView.indexPath = indexPath;
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableview = footerview;
    }
    
    return reusableview;
}


#pragma mark Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    FITExerciseHelper *exercise = self.exerciseList[indexPath.section];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGSize mElementSize = CGSizeMake((width-16-exercise.setsArray.count*4)/exercise.setsArray.count, 104);
    return mElementSize;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowExerciseInfo"]) {
        NSIndexPath *indexPath = [(ExerciseHeaderView *)[sender superview] indexPath];
        ExerciseInfoViewController *destViewController = segue.destinationViewController;
        FITExerciseHelper *exercise = self.exerciseList[indexPath.section];
        destViewController.exerciseName = exercise.name;
        destViewController.exerciseInfo = exercise.info;
        destViewController.exerciseImage = exercise.image;
        destViewController.exerciseVideoURLString = exercise.videoURLString;
    }
}
@end
