//
//  ProfileViewController.m
//  TweetMySteps
//
//  Created by Tittu on 11/20/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UserProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


@synthesize  delegate, userDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"Profile";
        
        self.tabBarItem.image=[UIImage imageNamed:@"User.png"];

    
    }
    return self;
}



-(void)viewDidAppear:(BOOL)animated
{
    _scrollView.delegate=self;
    
    [_scrollView setScrollEnabled:YES];
    
    [_scrollView setContentSize:CGSizeMake(320, 1000)];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lifetimeTweetsArray=@[@"Lifetime1",@"Lifetime2",@"Lifetime3"];

    vsTweetsArray=@[@"vs1",@"vs2",@"vs3"];
    


   // self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 1258.0f);
    [_profileSubView.layer setCornerRadius:5.0f];
    [_profileSubView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_profileSubView.layer setBorderWidth:1.0f];
    [_profileSubView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_profileSubView.layer setShadowOpacity:0.8];
    [_profileSubView.layer setShadowRadius:1.0];
    
    [_profileSubView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
  
    [_statsView.layer setCornerRadius:5.0f];
    [_statsView.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [_statsView.layer setBorderWidth:1.0f];
    [_statsView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_statsView.layer setShadowOpacity:0.8];
    [_statsView.layer setShadowRadius:1.0];
    
    [_statsView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    
    [self.tableView reloadData];
    
    self.userDataArray=delegate.dataSource;

    [self.scrollView addSubview:_profileSubView];
    
    [self.scrollView addSubview:_statsView];
    
    [self.scrollView addSubview:_segmentControl];
    
    [self.scrollView addSubview:self.tableView];
    
    [self setValues];

    
    
}

-(void) setValues{
     
    _profileNameLabel.text=[userDataArray objectForKey:@"name"];
    
    _twitterHandleLabel.text=[@"@" stringByAppendingString :[userDataArray objectForKey:@"screen_name"] ];
    
    
    //UIColor *background = [[UIColor alloc] initWithPatternImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[userDataArray objectForKey:@"profile_background_image_url_https"]]]]];

   // _profileView.backgroundColor=background;
    
    _locationStringLabel.text=[userDataArray objectForKey:@"location"];
    
    _descTextView.text=[userDataArray objectForKey:@"description"];
    
    _tweetCountLabel.text=[NSString stringWithFormat:@"%@",[userDataArray objectForKey:@"statuses_count"]];
    
    _followersCountLabel.text=[NSString stringWithFormat:@"%@",[userDataArray objectForKey:@"followers_count"]];
    
    _followingCountLabel.text=[NSString stringWithFormat:@"%@",[userDataArray objectForKey:@"friends_count"]];
    
    NSError *error;
    
    
    
    NSString *profileURLString=[@"http://m.tweetmysteps.com/profileInfoServiceJSON.php?userName=" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]];
    
    NSString *profileURLEncoded = [profileURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *profileURL=[NSURL URLWithString:profileURLEncoded];
    
    NSData *profileData=[NSData dataWithContentsOfURL:profileURL];
    
    
    NSArray *profileDataArray=[NSJSONSerialization JSONObjectWithData:profileData options:kNilOptions error:&error];
 
    
    if ([profileDataArray count]==0) {
        
        _statsView.hidden=YES;
        
         _tableView.hidden=YES;
        
        _segmentControl.hidden=YES;
        
        _scrollView.scrollEnabled=NO;

        _profileImageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://api.twitter.com/1/users/profile_image/" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]]]]];
        
    } else {
        
        
        _profileImageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[@"http://api.twitter.com/1/users/profile_image/" stringByAppendingString:[userDataArray objectForKey:@"screen_name"]]]]];
        
    }
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
        
        return [vsTweetsArray count];

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
    
    NSArray *dataArray=nil;
    
    if (_segmentControl.selectedSegmentIndex==0) {
        
        dataArray=lifetimeTweetsArray;
        
    } else{
        
        dataArray=vsTweetsArray;
        
    }
    
    cell.textLabel.text=dataArray[indexPath.row];
    

    return cell;
    
}




- (IBAction)segmentChanged:(id)sender {
    
    [self.tableView reloadData];
}
@end
