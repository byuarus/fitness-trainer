//
//  FITExerciseInfoViewController.m
//  FitTrainer
//
//  Created by Dmitry Malakhov on 19.06.16.
//  Copyright © 2016 Dmytro Malakhov. All rights reserved.
//

#import "FITExerciseInfoViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@import AVFoundation;
@import AVKit;

@interface FITExerciseInfoViewController ()

@end

@implementation FITExerciseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.exerciseNameLable.text = [self.exercise.name capitalizedString];
    self.exerciseInfoView.text = self.exercise.info;
    [self.exerciseImageView sd_setImageWithURL:[NSURL URLWithString:self.exercise.imageURLWithString]
placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.title = [self.exercise.name capitalizedString];

    [self.exerciseWebView setAllowsInlineMediaPlayback:YES];
    [self.exerciseWebView setMediaPlaybackRequiresUserAction:NO];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    
    NSString *embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width='%f' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                           </body>\
                           </html>", screenWidth+10, 190, self.exercise.youtubeVideoId];
    [self.exerciseWebView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
