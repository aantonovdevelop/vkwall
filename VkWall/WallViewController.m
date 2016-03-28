//
//  WallViewController.m
//  VkWall
//
//  Created by Denis Kreshikhin on 28.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import "WallViewController.h"

@implementation WallViewController{
    int onwerId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    onwerId = 1;
    
    self.tableView.delegate = self;
    NSLog(@"view did load");
    
    [self getWallWithOffset:0 count:100 andCompletion:^(NSError* error){
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@" number of posts");
    return 20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Title header";
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" indexpath %@ ", indexPath);
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell.textLabel setText:@"Cell text"];
    
    return cell;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"did scroll");
}


-(void)getWallWithOffset:(int)offset
                   count:(int)count
           andCompletion:(void(^)(NSError*))completion{
    NSString* urlString = [NSString stringWithFormat:@"https://api.vk.com/method/wall.get?owner_id=%d&offset=%d&count=%d", onwerId, offset, count];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSURLSessionTask* dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        if (error != nil) {
            NSLog(@"error %@ ", error);
            return;
        }
        
        NSError* jsonError = nil;
        
        id result = [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers
                                          error:&jsonError];
        
        if (error != nil) {
            NSLog(@"error %@ ", jsonError);
            return;
        }
        
        NSLog(@"json %@", result);
    }];
    
    [dataTask resume];
}

@end
