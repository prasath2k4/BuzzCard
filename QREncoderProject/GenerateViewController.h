//
//  GenerateViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>

@interface GenerateViewController : UIViewController <UITextFieldDelegate>
{
    NSMutableArray *contactArray;
    NSMutableArray *genConArray;
}

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UITextField *personDesignation;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *webUrl;
@property (weak, nonatomic) IBOutlet UITextField *streetDetails;
@property (weak, nonatomic) IBOutlet UITextField *cityName;
@property (weak, nonatomic) IBOutlet UITextField *countryName;
@property (weak, nonatomic) IBOutlet UITextField *postCode;
@property (weak, nonatomic) IBOutlet UITextField *faxNumber;

@property (weak, nonatomic) IBOutlet UIView *myView;

-(IBAction) createBuzzContact;

@end
