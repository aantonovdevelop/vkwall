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
    
    UIColor* lightBlue = [UIColor colorWithRed:0.5 green:0.75 blue:1.0 alpha:1.0];
    
    [self.navigationItem setTitle:@"Enter Id"];
    [self.view setBackgroundColor:lightBlue];
    
    CGFloat elementWidth = self.view.frame.size.width / 2;
    CGFloat elementLeftOffset = self.view.frame.size.width / 4;
    
    CGFloat elementHeight = self.view.frame.size.width / 6;
    CGFloat elementTopOffset = self.view.frame.size.height / 4;
    
    CGFloat fontSize = elementHeight / 4;
    CGFloat cornerRadius = elementHeight / 6;
    
    UIViewAutoresizing autoresizing = UIViewAutoresizingFlexibleWidth;
    
    CGRect fieldFrame = CGRectMake(elementLeftOffset, elementTopOffset - 2*elementHeight/3, elementWidth, elementHeight);
    self.idTextField = [[UITextField alloc] initWithFrame:fieldFrame];
    [self.idTextField setAutoresizingMask: autoresizing];
    [self.idTextField setFont:[UIFont fontWithName:@"Helvetica Bold" size:fontSize]];
    [self.idTextField setBackgroundColor:[UIColor whiteColor]];
    [self.idTextField setTextAlignment:NSTextAlignmentCenter];
    [self.idTextField setDelegate:self];
    
    CGRect buttonFrame = CGRectMake(elementLeftOffset, elementTopOffset + 2*elementHeight/3, elementWidth, elementHeight);
    self.showButton = [[UIButton alloc] initWithFrame:buttonFrame];
    [self.showButton setAutoresizingMask: autoresizing];
    [self.showButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Bold" size:fontSize]];
    [self.showButton setBackgroundColor:[UIColor whiteColor]];
    [self.showButton setTitle:@"Show Wall" forState:UIControlStateNormal];
    [self.showButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [self.showButton.layer setCornerRadius:cornerRadius];
    [self.showButton addTarget:self action:@selector(showWall:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view setAutoresizesSubviews:YES];
    [self.view addSubview:self.idTextField];
    [self.view addSubview:self.showButton];
}

-(void)showWall:(UIButton*)sender{
    NSString* wallId = [self.idTextField text];
    [self.idTextField resignFirstResponder];
    
    if([wallId isEqualToString:@""]){
        wallId = @"1";
    }
    
    [self.delegate showWallWithId:wallId];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.idTextField) {
        [textField resignFirstResponder];
        [self showWall:self.showButton];
        return NO;
    }
    
    return YES;
}

@end
