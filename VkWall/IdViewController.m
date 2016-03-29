//
//  IdViewController.m
//  VkWall
//
//  Created by Denis Kreshikhin on 29.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import "IdViewController.h"

@interface IdViewController()

@property (strong) UIButton* showButton;
@property (strong) UITextField* idTextField;

@end

@implementation IdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Enter Id"];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.75 blue:1.0 alpha:1.0]];
    
    CGFloat elementWidth = self.view.frame.size.width / 2;
    CGFloat elementLeftOffset = self.view.frame.size.width / 4;
    
    CGFloat elementHeight = self.view.frame.size.width / 4;
    CGFloat elementTopOffset = self.view.frame.size.height / 2;
    
    CGRect buttonFrame = CGRectMake(elementLeftOffset, elementTopOffset, elementWidth, elementHeight);
    self.showButton = [[UIButton alloc] initWithFrame:buttonFrame];
    
    [self.showButton setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
    
    [self.showButton setBackgroundColor:[UIColor redColor]];
    [self.showButton setTitle:@"Show Wall" forState:UIControlStateNormal];
    [self.showButton addTarget:self action:@selector(showWall:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view setAutoresizesSubviews:YES];
    [self.view addSubview:self.showButton];
}

-(void)showWall:(UIButton*)sender{
    NSString* wallId = @"1";
    
    [self.delegate showWallWithId:wallId];
}

@end
