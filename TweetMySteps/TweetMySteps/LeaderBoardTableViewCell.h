//
//  LeaderBoardTableViewCell.h
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/29/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface LeaderBoardTableViewCell : UITableViewCell{
    
}

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *twitterHandle;
@property (strong, nonatomic) IBOutlet UILabel *stepCount;
@property (strong, nonatomic) IBOutlet UILabel *comment;




@end
