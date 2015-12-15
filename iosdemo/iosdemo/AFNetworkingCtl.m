//
//  AFNetworkingCtl.m
//  iosdemo
//
//  Created by wangmo on 11/24/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "AFNetworkingCtl.h"
#import "AFNetworking/AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface AFNetworkingCtl ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@end

@implementation AFNetworkingCtl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"AFNetworkingCtl");
}

/**
 加载网络图片
 */
- (IBAction)AFNetworkingImageTest:(id)sender {
    
    [self.myImageView setImageWithURL:[NSURL URLWithString:@"http://7xnjxd.com1.z0.glb.clouddn.com/bigimg2.jpg"] placeholderImage:[UIImage imageNamed:@"icon_default"]];
}

- (IBAction)AFNGetJSON:(id)sender {
    
    self.myTextView.text = @"";
    
    /*
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager GET:@"http://7xkme5.com1.z0.glb.clouddn.com/movies2.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     //        NSLog(@"JSON: %@", responseObject);
     for (NSDictionary *item in responseObject) {
     self.myTextView.text = [self.myTextView.text stringByAppendingString:[item valueForKeyPath:@"title"]];
     self.myTextView.text = [self.myTextView.text stringByAppendingString:[item valueForKeyPath:@"url"]];
     }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     //        NSLog(@"Error: %@", error);
     self.myTextView.text = error.localizedDescription;
     }];
     */
}
/**
 Post
 没有实现真的Post
 */
- (IBAction)AFNPost:(id)sender {
    
    self.myTextView.text = @"";
    /*
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"name":@"wm"};
    [manager POST:@"http://127.0.0.1:1337/?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
        self.myTextView.text = error.localizedDescription;
    }];
     */
}

@end
