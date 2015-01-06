//
//  DetailViewController.h
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    NSString *personFirstName;
    NSString *personLastName;
    UIAlertView *alertPopUp;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *personDesign;
@property (weak, nonatomic) IBOutlet UILabel *personFullName;
@property (weak, nonatomic) IBOutlet UILabel *personDOB;
@property (weak, nonatomic) IBOutlet UIButton *personContactNum;
@property (weak, nonatomic) IBOutlet UIButton *personFaxNum;
@property (weak, nonatomic) IBOutlet UIButton *personEmailID;
@property (weak, nonatomic) IBOutlet UILabel *personCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *personWebsite;
@property (weak, nonatomic) IBOutlet UILabel *personAddress;
@property (weak, nonatomic) IBOutlet UILabel *personCity;
@property (weak, nonatomic) IBOutlet UILabel *personCountry;
@property (weak, nonatomic) IBOutlet UILabel *personPostCode;
@property (weak, nonatomic) IBOutlet UIButton *saveContact;


@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@property (strong, nonatomic) NSString *imageName;

-(IBAction)makeCall;
-(IBAction)sendEmail;
-(IBAction)openWebpage;
-(IBAction)saveContactToLocal;
@end
