//
//  LeaderBoardViewController.m
//  TweetMySteps
//
//  Created by Tittu on 11/19/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "LeaderBoardViewController.h"

@interface LeaderBoardViewController ()

@end

@implementation LeaderBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"Leader Board";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
