//
//  AppDelegate.h
//  TweetMySteps
//
//  Created by Tittu on 11/16/12.
//  Copyright (c) 2012 MindAgile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeaderBoardViewController;
@class ProfileViewController;
@class AboutViewController;
@class SettingsViewController;
@class TweetViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    UITabBarController *tabBarController;
    
    UINavigationController *homeNavController;
    
    LeaderBoardViewController *leaderBoardVC;
    
    ProfileViewController *profileVC;
    
    AboutViewController *aboutVC;
    
    SettingsViewController *settingsVC;
    
    TweetViewController *tweetVC;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (retain, nonatomic) UITabBarController *tabBarController;
@property (retain, nonatomic) UINavigationController *homeNavController;

@property (retain, nonatomic) LeaderBoardViewController *leaderBoardVC;
@property (retain, nonatomic) ProfileViewController *profileVC;
@property (retain, nonatomic) AboutViewController *aboutVC;
@property (retain, nonatomic) SettingsViewController *settingsVC;
@property (retain, nonatomic) TweetViewController *tweetVC;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
