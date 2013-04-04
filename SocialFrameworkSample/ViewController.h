//
//  ViewController.h
//  SocialFrameworkSample
//
//  Created by KazukiKubo on 2013/04/04.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ViewController : UIViewController {
    ACAccountStore* _acountStore;
}

@property(nonatomic, strong)IBOutlet UITextView* textView;

-(IBAction)sendToFacebook:(id)sender;
-(IBAction)showFacebookAccount:(id)sender;
-(IBAction)uploadPhotoToFacebook:(id)sender;

@end
