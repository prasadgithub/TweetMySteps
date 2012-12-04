//
//  DetailViewController.h
//  TweetMySteps
//
//  Created by Tittu on 12/3/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController{
    
    NSMutableArray *subTweetsArray;
    NSData *imageData;
    
}

@property (strong, nonatomic) NSMutableArray *subTweetsArray;

@end
