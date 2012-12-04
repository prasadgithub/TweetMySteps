//
//  DetailViewController.m
//  TweetMySteps
//
//  Created by Tittu on 12/3/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize subTweetsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableDictionary *tweetDictionary=[subTweetsArray lastObject];
    
    imageData= [NSData dataWithContentsOfURL:[NSURL URLWithString:[tweetDictionary objectForKey:@"IMG"]]];
    
    [self.tableView reloadData];

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"More Tweets";

        
    }
    return self;
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

    return [subTweetsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil];
        
        for (id obj in views) {
            
            if ([obj isKindOfClass:[UITableViewCell class]]) {
                cell=(DetailTableViewCell*) obj;
            }
            
        }
        
    }
    
    
    NSMutableDictionary *tweetDictionary=[subTweetsArray objectAtIndex:indexPath.row];
    
    cell.imageView.image=[UIImage imageWithData:imageData];
    
    cell.handleLable.text=[@"@" stringByAppendingString:[tweetDictionary objectForKey:@"HNDL"]];

    cell.stepCountLabel.text=[NSString stringWithFormat:@"%@",[tweetDictionary objectForKey:@"STEPS"]];
    
    cell.timeLabel.text=[tweetDictionary objectForKey:@"TIME"];
    
    cell.commentTextView.text=[tweetDictionary objectForKey:@"COMMENT"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end