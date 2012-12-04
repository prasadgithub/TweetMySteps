//
//  UserProfileViewController.m
//  TweetMySteps
//
//  Created by Tittu on 12/2/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserProfileLifeTimeTableViewCell.h"
#import "DetailViewController.h"
#import "NoDisplayTableViewCell.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

@synthesize username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
        self.title=@"Profile";
        
    
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    _scrollView.delegate=self;
    
    [_scrollView setScrollEnabled:YES];
    
    [_scrollView setContentSize:CGSizeMake(320, 900)];
    
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    

    [_profileView.layer setCornerRadius:5.0f];
    [_profileView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_profileView.layer setBorderWidth:1.0f];
    [_profileView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_profileView.layer setShadowOpacity:0.8];
    [_profileView.layer setShadowRadius:1.0];
    [_profileView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    
    [_statsView.layer setCornerRadius:5.0f];
    [_statsView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_statsView.layer setBorderWidth:1.0f];
    [_statsView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_statsView.layer setShadowOpacity:0.8];
    [_statsView.layer setShadowRadius:1.0];
    
    [_statsView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    [self setValues];
    
    [self.tableView reloadData];

}




-(void) setValues{
    
    
    NSError *error;
    
    NSString *profileURLString=[@"http://m.tweetmysteps.com/profileInfoServiceJSON.php?userName=" stringByAppendingString:username];
    
    NSString *profileURLEncoded = [profileURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *profileURL=[NSURL URLWithString:profileURLEncoded];
    
    NSData *profileData=[NSData dataWithContentsOfURL:profileURL];
    
    
    NSArray *profileDataArray=[NSJSONSerialization JSONObjectWithData:profileData options:kNilOptions error:&error];
    
    NSMutableDictionary *userDataDictionary=[profileDataArray lastObject];
    
    _nameLabel.text=[userDataDictionary objectForKey:@"name"];
    
    _twitterHandle.text=[@"@" stringByAppendingString :username ];
    

    _location.text=[userDataDictionary objectForKey:@"location"];
    
    _descTextView.text=[userDataDictionary objectForKey:@"desc"];
    
    data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://api.twitter.com/1/users/profile_image/" stringByAppendingString:username]]];
    _profileImage.image=[[UIImage alloc] initWithData:data];
    
    _memberSinceDate.text=[userDataDictionary objectForKey:@"memberDate"];
    _avgStepsLabel.text=[userDataDictionary objectForKey:@"avgStep"];
    
    _bestStepsDayLabel.text=[userDataDictionary objectForKey:@"maxStepDay"];
    
    _tenKDaysLabel.text=[userDataDictionary objectForKey:@"tenKDays"];
    
    _tenKStreakLabel.text=[NSString stringWithFormat:@"%@",[userDataDictionary objectForKey:@"tenKStreaks"]];
    
    _todayStepCountLabel.text=[[[[userDataDictionary objectForKey:@"todaySteps"] stringByAppendingString:@" steps ("] stringByAppendingString:[userDataDictionary objectForKey:@"todayMiles"]] stringByAppendingString:@" Mi)"];
    
    _lifetimeStepCountLabel.text=[[[[userDataDictionary objectForKey:@"lifetimeSteps"] stringByAppendingString:@" steps ("] stringByAppendingString:[userDataDictionary objectForKey:@"lifetimeMiles"]] stringByAppendingString:@" Mi)"];
    
    _vsBattlesLabel.text=[userDataDictionary objectForKey:@"vsBattles"];
    
    _vsWinsLabel.text=[userDataDictionary objectForKey:@"vsWins"];
    
    
    NSString *lifetimeTweetsURLString=[@"http://m.tweetmysteps.com/profileUpdateServiceJSON.php?username=" stringByAppendingString:username];

    NSString *lifetimeTweetsURLEncoded = [lifetimeTweetsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *lifetimeTweetsURL=[NSURL URLWithString:lifetimeTweetsURLEncoded];
    
    NSData *lifetimeTweetData=[NSData dataWithContentsOfURL:lifetimeTweetsURL];
    
    
   lifetimeTweetsArray=[NSJSONSerialization JSONObjectWithData:lifetimeTweetData options:kNilOptions error:&error];
   
       
    NSString *vsTweetsURLString=[@"http://m.tweetmysteps.com/profileUpdateServiceVSJSON.php?username=" stringByAppendingString:username];
    

    NSString *vsTweetsURLEncoded = [vsTweetsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *vsTweetsURL=[NSURL URLWithString:vsTweetsURLEncoded];
    
    NSData *vsTweetData=[NSData dataWithContentsOfURL:vsTweetsURL];

    vsTweetsArray=[NSJSONSerialization JSONObjectWithData:vsTweetData options:kNilOptions error:&error];
    
    noTweetMSG=@"No sweet versus action yet. Stay tuned...";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        return [lifetimeTweetsArray count];
        
        
    }else{
        if ([vsTweetsArray count]>0) {
 
            return [vsTweetsArray count];
            
        }else
            return 1;
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    NSArray *dataArray=nil;
    

    if (_segmentControl.selectedSegmentIndex==0) {
        
        
        UserProfileLifeTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            
            NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"UserProfileLifetimeTableViewCell" owner:nil options:nil];
            
            for (id obj in views) {
                
                if ([obj isKindOfClass:[UITableViewCell class]]) {
                    cell=(UserProfileLifeTimeTableViewCell*) obj;
                }
                
            }
            
        }
        
         dataArray=lifetimeTweetsArray;
        
        NSMutableDictionary *tweet=[dataArray objectAtIndex:indexPath.row];
        
        cell.handleLabel.text=[@"@" stringByAppendingString :[tweet objectForKey:@"HNDL"]];
        
        cell.profileTabPic.image=[UIImage imageWithData:data];
        
        cell.stepCountLabel.text=[tweet objectForKey:@"STEPS"];
        
        cell.commentTextView.text=[tweet objectForKey:@"COMMENT"];
        
        cell.timeLabel.text=[tweet objectForKey:@"TIME"];
        
        return cell;
        
        
        
    }else{
        
        dataArray=vsTweetsArray;
        
        if ([dataArray count]==0) {
            
            static NSString *CellIdentifier = @"Cell21";
            
            
            NoDisplayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                
                NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"NoDisplayTableViewCell" owner:nil options:nil];
                for (id obj in views) {
                    
                    if ([obj isKindOfClass:[UITableViewCell class]]) {
                        cell=(NoDisplayTableViewCell*) obj;
                    }
                    
                    
                }
                
            }
            
            cell.message.text=noTweetMSG;
            
            return cell;
            
        }else{
            
            UserProfileLifeTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell 22"];
            
            
            if (cell == nil) {
                
                NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"UserProfileLifetimeTableViewCell" owner:nil options:nil];
                
                for (id obj in views) {
                    
                    if ([obj isKindOfClass:[UITableViewCell class]]) {
                        cell=(UserProfileLifeTimeTableViewCell*) obj;
                    }
                    
                }
                
            }
            
            
            
            NSMutableDictionary *tweet=[dataArray objectAtIndex:indexPath.row];
            
            cell.handleLabel.text=[@"@" stringByAppendingString :[tweet objectForKey:@"HNDL"]];
            
            cell.profileTabPic.image=[UIImage imageWithData:data];
            
            cell.stepCountLabel.text=[tweet objectForKey:@"STEPS"];
            
            cell.commentTextView.text=[tweet objectForKey:@"COMMENT"];
            
            return cell;
   
            
        }
        
    }

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *tweetData=[lifetimeTweetsArray objectAtIndex:indexPath.row];
    
      
    if ([tweetData objectForKey:@"SUBTWEETS"]!=[NSNull null]) {
        
        
        DetailViewController *detailVC=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
        
        detailVC.subTweetsArray=[tweetData objectForKey:@"SUBTWEETS"];
        
        
        [self.navigationController pushViewController:detailVC animated:YES];
        
        
    }

    
}

- (IBAction)segmentChanged:(id)sender {
    
    
    [self.tableView reloadData];

}
@end
