//
//  NewContactViewController.h
//  BUZZ
//
//  Created by student on 17/9/14.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import <AddressBook/AddressBook.h>

@interface NewContactViewController : UIViewController <NSURLSessionDataDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
   __weak UITextField *designation;
   __weak UITextField *firstName;
   __weak UITextField *lastName;
   __weak UITextField *contactNumber;
   __weak UITextField *emailId;
   __weak UITextField *companyName;
   __weak UITextField *webUrl;
   __weak UITextField *addressDetails;
   __weak UITextField *cityName;
   __weak UITextField *countyName;
   __weak UITextField *postCode;
    
    NSString *databasePath;
    
    sqlite3 *contactDB;
    sqlite3_stmt *insertStatement;
    sqlite3_stmt *updateStatement;
    sqlite3_stmt *deleteStatement;
    sqlite3_stmt *selectStatement;
    //sqlite3_stmt *selectContact;
    
    NSString *contactToDelete;
}

@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)NSMutableData *buffer;

@property (weak, nonatomic) IBOutlet UITextField *designation;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;
@property (weak, nonatomic) IBOutlet UITextField *faxNumber;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *webUrl;
@property (weak, nonatomic) IBOutlet UITextField *addressDetails;
@property (weak, nonatomic) IBOutlet UITextField *cityName;
@property (weak, nonatomic) IBOutlet UITextField *countryName;
@property (weak, nonatomic) IBOutlet UITextField *postCode;

@property (weak, nonatomic) IBOutlet UIImageView *scannedContactImage;
@property (strong, nonatomic) UIImageView *scanImg;
@property (strong, nonatomic) NSString *imageName;
@property int i;
@property (strong, nonatomic)  NSString *contactToAttach;
@property (strong, nonatomic) NSString *newlyRecievedContact;

@property (weak, nonatomic) IBOutlet UIView *myView;


-(void) getContactDetails;
-(IBAction)saveContact;
-(void) findContact;
-(void) deleteContact:(NSString *) numberToDelete;

@end
