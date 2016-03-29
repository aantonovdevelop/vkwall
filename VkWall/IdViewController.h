//
//  IdViewController.h
//  VkWall
//
//  Created by Denis Kreshikhin on 29.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IdViewControllerDelegate

-(void)showWallWithId:(NSString*)wallId;

@end

@interface IdViewController : UIViewController
@property (weak) id delegate;
@end
