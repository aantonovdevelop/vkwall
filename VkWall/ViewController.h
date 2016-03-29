//
//  ViewController.h
//  VkWall
//
//  Created by Denis Kreshikhin on 28.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WallViewController.h"
#import "PostViewController.h"
#import "IdViewController.h"

@interface ViewController : UINavigationController<
    WallViewControllerDelegate
>

@property (strong) WallViewController* wallViewController;
@property (strong) PostViewController* postViewController;
@property (strong) IdViewController* idViewController;

@end

