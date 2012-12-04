//
//  NoDisplayTableViewCell.h
//  TweetMySteps
//
//  Created by Tittu on 11/30/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDisplayTableViewCell : UITableViewCell{
    
    IBOutlet UITextView *message;
    
}
@property (strong, nonatomic) IBOutlet UITextView *message;

@end
