//
//  LeaderBoardViewController.h
//  TweetMySteps
//
//  Created by Tittu on 11/21/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

extern NSString * const BannerViewActionWillBegin;
extern NSString * const BannerViewActionDidFinish;
@interface LeaderBoardViewController : UITableViewController{
    
    UIRefreshControl *refreshControl;
    
    NSArray *todayTweetsArray;
    
    NSArray *weekTweetsArray;
    
    NSArray *lifetimeTweetsArray;
    
    NSString *noTweetMSG;
    
    

}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;



- (IBAction)segmentChanged:(id)sender;

@end
