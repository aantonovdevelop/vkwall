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
    
    self.wallViewController.delegate = self;
    
    [self pushViewController:self.wallViewController animated:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showPost:(NSString *)text{
    if([self topViewController] != self.postViewController){
        [self.postViewController setText:text];
        [self pushViewController:self.postViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
