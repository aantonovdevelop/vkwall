//
//  PostViewController.m
//  VkWall
//
//  Created by Denis Kreshikhin on 29.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController()
@property (strong) UITextView* textView;
@end


@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Post"];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.frame];
    [self.textView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    [self.view addSubview:self.textView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.textView setText:self.text];
    
    //[self.text ]
    
    [super viewWillAppear:animated];
}

@end
