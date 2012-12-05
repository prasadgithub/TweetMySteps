//
//  TweetViewController.m
//  TweetMySteps
//
//  Created by Prasad Pamidi on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "TweetViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "UserProfileViewController.h"

#import "UserProfileLifeTimeTableViewCell.h"

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
    
    data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[_tweet objectForKey:@"IMG"]] ];
    
    _profileImage.image=[[UIImage alloc] initWithData:data];
    
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


-(void) viewWillAppear:(BOOL)animated{
    
    
    
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
    
    UserProfileLifeTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"UserProfileLifetimeTableViewCell" owner:nil options:nil];
        
        for (id obj in views) {
            
            if ([obj isKindOfClass:[UITableViewCell class]]) {
                cell=(UserProfileLifeTimeTableViewCell*) obj;
            }
            
        }
        
    }
    
    
    
    NSMutableDictionary *tweet=[subTweets objectAtIndex:indexPath.row];
    
    cell.handleLabel.text=[@"@" stringByAppendingString :[tweet objectForKey:@"HNDL"]];
    
    cell.profileTabPic.image=[UIImage imageWithData:data];
    
    cell.stepCountLabel.text=[NSString stringWithFormat:@"%@",[tweet objectForKey:@"STEPS"]];
    
    cell.commentTextView.text=[tweet objectForKey:@"COMMENT"];
    
    cell.timeLabel.text=[tweet objectForKey:@"TIME"];
    


    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    UserProfileViewController *userProfileVC=[[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:[NSBundle mainBundle]];
    
    userProfileVC.username=[_tweet objectForKey:@"HNDL"];
    
    [self.navigationController pushViewController:userProfileVC animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
