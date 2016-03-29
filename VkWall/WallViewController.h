//
//  WallViewController.h
//  VkWall
//
//  Created by Denis Kreshikhin on 28.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WallViewControllerDelegate <NSObject>
-(void)showPostWithText:(NSString*)text;
@end

@interface WallViewController : UITableViewController<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (atomic) NSString* wallId;
@property (weak) id delegate;

-(void)reloadData;
@end
