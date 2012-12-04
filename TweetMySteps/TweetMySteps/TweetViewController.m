//
//  TweetViewController.m
//  TweetMySteps
//
//  Created by Tittu on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "TweetViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "UserProfileViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

@synthesize subTweets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"Tweet";
    
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    _scrollView.delegate=self;
    
    [_scrollView setScrollEnabled:YES];
    
    [_scrollView setContentSize:CGSizeMake(320, 600)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    [_tweetView.layer setCornerRadius:5.0f];
    [_tweetView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_tweetView.layer setBorderWidth:1.0f];
    [_tweetView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_tweetView.layer setShadowOpacity:0.8];
    [_tweetView.layer setShadowRadius:1.0];
    
    [_tweetView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    _twitterHandleLabel.text=[@"@" stringByAppendingString:[_tweet objectForKey:@"HNDL"]] ;
    
    _profileImage.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_tweet objectForKey:@"IMG"]]]];
    
    _stepCountLabel.text=[_tweet objectForKey:@"STEPS"];
    
    _tweetTextView.text=[_tweet objectForKey:@"COMMENT"];
    
    _nameLabel.text=[_tweet objectForKey:@"NAME"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    
    [_tweetView addGestureRecognizer:tapRecognizer];
    
    
    if ([_tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
        
        
        subTweets=[_tweet objectForKey:@"SUBTWEETS"];

        [self.tableView reloadData];
        
        
    }
    
  
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    
    UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
    
    userProfileVC.username=[_tweet objectForKey:@"HNDL"];
    
    [self.navigationController pushViewController:userProfileVC animated:YES];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 1;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([_tweet objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
        
        return [subTweets count];
    
    }else{
        
        return 0;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell=nil;
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (indexPath.section==0) {
        
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
            
        }
        
        
        
    }
    

    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
