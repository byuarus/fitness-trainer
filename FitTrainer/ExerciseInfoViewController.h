//
//  ExerciseInfoViewController.h
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLable;
@property (strong, nonatomic) IBOutlet UITextView *exerciseInfoView;
@property (strong, nonatomic) IBOutlet UIImageView *exerciseImageView;
@property (strong, nonatomic) IBOutlet UIImageView *exerciseThumbnailView;
@property (strong, nonatomic) IBOutlet UIWebView *exerciseWebView;
@property (strong, nonatomic) NSString *exerciseName;
@property (strong, nonatomic) NSString *exerciseVideoURLString;
@property (strong, nonatomic) UIImage *exerciseImage;
@property (strong, nonatomic) NSString *exerciseInfo;
@end
