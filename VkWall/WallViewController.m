//
//  WallViewController.m
//  VkWall
//
//  Created by Denis Kreshikhin on 28.03.16.
//  Copyright © 2016 Denis Kreshikhin. All rights reserved.
//

#import "WallViewController.h"

@interface WallViewController ()
@property (strong, atomic) NSMutableArray* posts;
@property (atomic) bool isRequestFinished;
@end

@implementation WallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRequestFinished = YES;
    
    self.posts = [[NSMutableArray alloc] init];
    
    self.wallId = @"1";
    
    self.tableView.delegate = self;
    NSLog(@"view did load");
}

-(void)viewWillAppear:(BOOL)animated{
    self.posts = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    
    [self requestNextPosts];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Wall %@", self.wallId]];

    [super viewWillAppear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger result = 0;
    @synchronized(self.posts) {
        result = [self.posts count];
    }
    return result;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSString* post = nil;
    @synchronized(self.posts) {
        post = [self.posts objectAtIndex:[indexPath section]];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell.textLabel setText:post];
    
    return cell;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
    {
        [self requestNextPosts];
    }
}


-(void)getWallWithOffset:(int)offset
                   count:(int)count
           andCompletion:(void(^)(NSError*))completion{
    NSString* urlString = [NSString stringWithFormat:@"https://api.vk.com/method/wall.get?owner_id=%@&offset=%d&count=%d&version=5.50", self.wallId, offset, count];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSURLSessionTask* dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        if (error != nil) {
            completion(error);
            return;
        }
        
        NSError* jsonError = nil;
        
        id result = [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers
                                          error:&jsonError];
        
        if (jsonError != nil) {
            completion(jsonError);
            return;
        }
        
        NSArray* items = [result objectForKey:@"response"];
        
        if (items == nil) {
            completion(nil);
            return;
        }
        
        @synchronized(self.posts) {
            for (id item in items) {
                if([item isKindOfClass:[NSDictionary class]] == NO) continue;
                
                if([item objectForKey:@"text"] == nil ||
                   [[item objectForKey:@"text"] isEqualToString:@""]) {
                    [self.posts addObject:@"[non-text post]"];
                    continue;
                }
                
                [self.posts addObject:[item objectForKey:@"text"]];
            }
        }
    
        completion(nil);
    }];
    
    [dataTask resume];
}

-(void)requestNextPosts{
    if(self.isRequestFinished != YES) return;
    
    self.isRequestFinished = NO;
    [self getWallWithOffset:(int)[self.posts count] count:30 andCompletion:^(NSError* error){
        if (error != nil) {
            self.isRequestFinished = YES;
            return;
        }
        
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        self.isRequestFinished = YES;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* text;
    
    NSLog(@"selected!");
    
    @synchronized(self.posts) {
        text = [self.posts objectAtIndex:[indexPath section]];
    }
    
    [self.delegate showPostWithText:text];
}

@end
