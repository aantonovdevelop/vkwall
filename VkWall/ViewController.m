//
//  ViewController.m
//  VkWall
//
//  Created by Denis Kreshikhin on 28.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wallViewController = [[WallViewController alloc] initWithStyle:UITableViewStylePlain];
    self.postViewController = [[PostViewController alloc] init];
    self.idViewController = [[IdViewController alloc] init];
    
    self.wallViewController.delegate = self;
    self.idViewController.delegate = self;
    
    [self preloadViewControllers];
    
    [self pushViewController:self.idViewController animated:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)preloadViewControllers{
    [self.wallViewController view];
    [self.postViewController view];
    [self.idViewController view];
}

-(void)showPostWithText:(NSString *)text{
    if([self topViewController] != self.postViewController){
        [self.postViewController setText:text];
        [self pushViewController:self.postViewController animated:YES];
    }
}

-(void)showWallWithId:(NSString*)wallId{
    if([self topViewController] != self.wallViewController){
        [self.wallViewController setWallId:wallId];
        [self pushViewController:self.wallViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
