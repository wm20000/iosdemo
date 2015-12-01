//
//  MyWebViewXIB.m
//  iosdemo
//
//  Created by wangmo on 12/1/15.
//  Copyright © 2015 wmios. All rights reserved.
//

#import "MyWebViewXIB.h"

@interface MyWebViewXIB () <UISearchBarDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForWard;

@end

@implementation MyWebViewXIB

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self search:nil];
}

-(void) search:(NSString *) keyWord{
    
    NSURL *url;
    if(keyWord == nil){
        url = [NSURL URLWithString:@"http://m.baidu.com"];
    }else if([keyWord containsString:@"http://"]){
        url = [NSURL URLWithString:keyWord];
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", keyWord]];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self search:searchBar.text];
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    [self search:searchBar.text];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    self.goBack.enabled = self.webView.canGoBack;
    self.goForWard.enabled = self.webView.canGoForward;
}
@end
