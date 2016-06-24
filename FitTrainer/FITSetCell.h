//
//  FITSetCell.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 18.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITSetCell : UICollectionViewCell

@property (nonatomic, getter=isComplete) BOOL complete;
@property (strong, nonatomic) IBOutlet UILabel *weight;
@property (strong, nonatomic) IBOutlet UILabel *repetitions;

@end
