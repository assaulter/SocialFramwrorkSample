//
//  ViewController.m
//  SocialFrameworkSample
//
//  Created by KazukiKubo on 2013/04/04.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _acountStore = [ACAccountStore new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showFacebookAccount:(id)sender {
    ACAccountType* facebookType = [_acountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary* options = @{ACFacebookAppIdKey : @"357120451074230",
                              ACFacebookPermissionsKey : @[@"email"],
                              ACFacebookAudienceKey : ACFacebookAudienceOnlyMe};
    
    [_acountStore requestAccessToAccountsWithType:facebookType options:options completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSLog(@"granted !!");
        }
    }];
}

-(IBAction)sendToFacebook:(id)sender {
    ACAccountType* facebookType = [_acountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary* options = @{ACFacebookAppIdKey : @"357120451074230",
                              ACFacebookPermissionsKey : @[@"publish_actions"],
                              ACFacebookAudienceKey : ACFacebookAudienceOnlyMe};
    
    [_acountStore requestAccessToAccountsWithType:facebookType options:options completion:^(BOOL granted, NSError *error) {
        if (granted) {
            [self postMessageWithType:facebookType];
        }
    }];
}

-(IBAction)uploadPhotoToFacebook:(id)sender {
    ACAccountType* facebookType = [_acountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSDictionary* options = @{ACFacebookAppIdKey : @"357120451074230",
                              ACFacebookPermissionsKey : @[@"publish_actions"],
                              ACFacebookAudienceKey : ACFacebookAudienceOnlyMe};
    
    [_acountStore requestAccessToAccountsWithType:facebookType options:options completion:^(BOOL granted, NSError *error) {
        if (granted) {
            [self uploadPhotoWithType:facebookType];
        }
    }];
}

- (void)addAccountText:(NSString *)text {
    NSString *string = [NSString stringWithFormat:@"%@\n%@", self.textView.text, text];
    [self.textView setText:string];
}

-(void)uploadPhotoWithType:(ACAccountType*)type {
    NSString* urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me/photos"];
    NSURL* url = [NSURL URLWithString:urlString];
    NSDictionary* params = [NSDictionary dictionaryWithObject:@"facebook photo upload test" forKey:@"message"];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                            requestMethod:SLRequestMethodPOST
                                                      URL:url
                                               parameters:params];
    /// addMultipartDataで、写真を投稿する
    NSData* photo = [[NSData alloc] initWithData:UIImagePNGRepresentation([UIImage imageNamed:@"namekuji700.jpg"])];
    [request addMultipartData:photo withName:@"withname" type:@"multipart/form-data" filename:@"filename"];
    
    [request setAccount:[[_acountStore accountsWithAccountType:type] objectAtIndex:0]];
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSLog(@"response : %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    }];
}

- (void)postMessageWithType:(ACAccountType*)type {
    NSString* urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me/feed"];
    NSURL* url = [NSURL URLWithString:urlString];
    NSDictionary* params = [NSDictionary dictionaryWithObject:@"facebook post test" forKey:@"message"];
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                            requestMethod:SLRequestMethodPOST
                                                      URL:url
                                               parameters:params];
    [request setAccount:[[_acountStore accountsWithAccountType:type] objectAtIndex:0]];
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSLog(@"response : %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    }];
}

@end
