//
//  NewContactViewController.m
//  BUZZ
//
//  Created by student on 17/9/14.
//
//

#import "NewContactViewController.h"

#import <AudioToolbox/AudioToolbox.h>


@interface NewContactViewController ()


@end

@implementation NewContactViewController


@synthesize detail,window,designation,firstName,lastName,contactNumber,emailId,companyName,webUrl,addressDetails,cityName,countryName,postCode,faxNumber,i,contactToAttach,newlyRecievedContact;

@synthesize scannedContactImage,imageName,buffer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:(BOOL) animated];
    self.designation=nil;
    self.firstName=nil;
    self.lastName=nil;
    self.contactNumber=nil;
    self.faxNumber=nil;
    self.emailId=nil;
    self.companyName=nil;
    self.webUrl=nil;
    self.addressDetails=nil;
    self.cityName=nil;
    self.countryName=nil;
    self.postCode=nil;
    self.scannedContactImage=nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL) animated];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    contactToDelete = contactNumber.text;
}


-(void)takePhoto
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.scannedContactImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    NSString *name1 = [self.firstName.text stringByAppendingString:@" "];
    NSString *name2 = [name1 stringByAppendingString:self.lastName.text];
    
    
    NSArray *myStrings = [[NSArray alloc] initWithObjects: name2, self.contactNumber.text, nil];
    
    imageName = [myStrings componentsJoinedByString:@"|"];
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.scannedContactImage.image)            forKey:imageName];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}




/*
-(void) goBack
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
}
 */

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [designation resignFirstResponder];
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [contactNumber resignFirstResponder];
    [emailId resignFirstResponder];
    [companyName resignFirstResponder];
    [webUrl resignFirstResponder];
    [addressDetails resignFirstResponder];
    [cityName resignFirstResponder];
    [countryName resignFirstResponder];
    [postCode resignFirstResponder];
    [faxNumber resignFirstResponder];
    
    return  YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slate.PNG"]];

    
    designation.delegate=self;
    firstName.delegate=self;
    lastName.delegate=self;
    contactNumber.delegate=self;
    emailId.delegate=self;
    companyName.delegate=self;
    webUrl.delegate=self;
    addressDetails.delegate=self;
    cityName.delegate=self;
    countryName.delegate=self;
    postCode.delegate=self;
    faxNumber.delegate=self;
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

    
    
    
    //NSUserDefaults *sud = [NSUserDefaults standardUserDefaults];
    //NSString *myString = [self newlyRecievedContact];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    //contactToAttach = [prefs stringForKey:@"ContactToAppend"];
    
    //NSString *myString = myqr.recievedContact;


            
            NSString *myString = [prefs stringForKey:@"newContact"];
            NSArray *splitContact = [myString componentsSeparatedByString:@"|"];
    
    firstName.text = splitContact[0];
    lastName.text = splitContact[1];
    designation.text = splitContact[2];
    //dateOfBirth.text = splitContact[3];
    contactNumber.text=splitContact[4];
    faxNumber.text=splitContact[5];
    emailId.text=splitContact[6];
    companyName.text=splitContact[7];
    webUrl.text=splitContact[8];
    addressDetails.text=splitContact[9];
    cityName.text=splitContact[10];
    countryName.text=splitContact[11];
    postCode.text=splitContact[12];
        
    //resetting the recieved contact to null
    
    //[sud setObject:NULL forKey:@"Contact"];
   // NSLog(@"the new contact data is %@", [sud stringForKey:@"Contact"]);

    [prefs setObject:NULL forKey:@"newContact"];

    
    
    NSUserDefaults *prefs11 = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    contactToAttach = [prefs11 stringForKey:@"ContactToAppend"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    [prefs1 setObject:contactNumber.text forKey:@"FetchContact"];
    
    
}

-(void) prepareStatement

{
    
    NSString *docsDir;
    docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Contacts.sqlite"]];
    const char *dbPath = [databasePath UTF8String];
    
    if(sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
    {
        char *errMsg;
        const char *sql_Stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (IMAGENAME TEXT, DESIGNATION TEXT, FIRSTNAME TEXT, LASTNAME TEXT, BIRTHDATE TEXT, CONTACTNUMBER TEXT, FAXNUMBER TEXT, EMAILID TEXT, COMPANYNAME TEXT, WEBSITE TEXT, ADDRESS TEXT, CITY TEXT, COUNTRY TEXT, POSTCODE TEXT)";
        
        if(sqlite3_exec(contactDB, sql_Stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create table");
        }
        
        
    }
    else{
        NSLog(@"Failed to open/create database");
    }
    
    NSString *sqlString;
    const char *sql_Stmt;
    
    //insert contact
    sqlString = [NSString stringWithFormat:@"INSERT INTO CONTACTS (imagename, designation, firstname, lastname, birthdate, contactnumber, faxnumber, emailid, companyname, website, address, city, country, postcode) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
    sql_Stmt = [sqlString UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &insertStatement,NULL);
    sqlite3_close(contactDB);
    
    //delete contact
    sqlString = [NSString stringWithFormat:@"DELETE FROM CONTACTS WHERE contactnumber = ?"];
    sql_Stmt = [sqlString UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt, -1, &deleteStatement, NULL);
    sqlite3_close(contactDB);

    
}

-(void) deleteContact:(NSString *)numberToDelete
{
    
    [self prepareStatement];
    
    sqlite3_bind_text(deleteStatement,1, [numberToDelete UTF8String], -1, SQLITE_TRANSIENT);
    
    if(sqlite3_step(deleteStatement)==SQLITE_DONE)
    {
        NSLog(@"contact delete");
    }
    else{
        NSLog(@"delete error is %s", sqlite3_errmsg(contactDB));
    }
    sqlite3_reset(deleteStatement);
    sqlite3_clear_bindings(deleteStatement);
    
    sqlite3_finalize(deleteStatement);
    sqlite3_close(contactDB);
}

-(void) saveContact
{
    [self prepareStatement];
        
    [self deleteContact:contactToDelete];

    
    //making full name
    
    NSString *fullName = firstName.text;
    fullName = [fullName stringByAppendingString:@" "];
    fullName = [fullName stringByAppendingString:lastName.text];
    
    //
    
    NSString *birthDate = @"nodate";
    sqlite3_bind_text(insertStatement, 1, [self.imageName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 2, [designation.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 3, [fullName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 4, [lastName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 5, [birthDate UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 6, [contactNumber.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 7, [faxNumber.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 8, [emailId.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 9, [companyName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 10, [webUrl.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 11, [addressDetails.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 12, [cityName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 13, [countryName.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertStatement, 14, [postCode.text UTF8String], -1, SQLITE_TRANSIENT);
    
    
    if(sqlite3_step(insertStatement) == SQLITE_DONE)
    {
        NSLog(@"Contact is added");
        
       // [self saveContactToLocal];
        
        UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                                   
                                                             message:@"Contact Saved"
                                   
                                                            delegate:self cancelButtonTitle:@"OK"
                                   
                                                   otherButtonTitles:nil];
        
        [alertPopUp show];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        //
        
        
        
        NSString * storyboardName = @"Main";
        NSString * viewControllerID = @"TabControl";
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UINavigationController * controller = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
        [self presentViewController:controller animated:YES completion:nil];
        
       
        
    }
    else
    {
        NSLog(@"Failed to add contact %s", sqlite3_errmsg(contactDB));
        
        UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                                   
                                                             message:@"Unable to save contact"
                                   
                                                            delegate:self cancelButtonTitle:@"Ok"
                                   
                                                   otherButtonTitles:nil];
        
        [alertPopUp show];
    }
   

    sqlite3_reset(insertStatement);
    sqlite3_clear_bindings(insertStatement);
    
    sqlite3_finalize(insertStatement);
    sqlite3_close(contactDB);
    
    //
    
    NSString *name1 = [self.firstName.text stringByAppendingString:@" "];
    NSString *name2 = [name1 stringByAppendingString:self.lastName.text];
    
    
    NSArray *myStrings = [[NSArray alloc] initWithObjects: name2, self.contactNumber.text, nil];
    
    imageName = [myStrings componentsJoinedByString:@"|"];
    
    NSLog(@"the image name is %@",imageName);
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.scannedContactImage.image)            forKey:imageName];
    
    //
    [self findContact];
}


-(void) findContact


{
    [self prepareStatement];
    
    NSString *sqlString1;
    const char *sql_Stmt1;
    //int rc=0;
    sqlString1 = [NSString stringWithFormat:@"SELECT designation, firstname, lastname, companyname, contactnumber FROM contacts order by firstname COLLATE NOCASE , companyname COLLATE NOCASE ASC;"];
    sql_Stmt1 = [sqlString1 UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt1, -1, &selectStatement, NULL);
    
    // sqlite3_bind_text(selectStatement, 1, <#const char *#>, <#int n#>, <#void (*)(void *)#>)
    
    if(sqlite3_step(selectStatement) == SQLITE_ROW)
    {
        
        NSMutableArray *contArr = [[NSMutableArray alloc] init];
        
        //new
        NSMutableArray *designationArr = [[NSMutableArray alloc] init];

        NSMutableArray *personContactArray =[[NSMutableArray alloc] init];
        
        do
        {
            
            NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            [contArr addObject:name];
            
            //new
            NSString * design = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            [designationArr addObject:design];
            
            //new
            NSString *company = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)];
            
            NSString *number = [NSString stringWithUTF8String:(char *) sqlite3_column_text(selectStatement, 4)];
            
            //personContact array
            
            //personContactArray = [[NSArray alloc] initWithObjects: name,design, nil];
            //NSString *personContact = [NSString stringWithFormat:@"%@|%@|%@",name,design,number];
            
            NSString *finalText =  [NSString stringWithFormat:@"%@\r%@-%@\r%@",name,company,design,number];
            
            NSLog(@"Final text is %@",finalText);

            
            [personContactArray addObject:finalText];
            
        } while (sqlite3_step(selectStatement) == SQLITE_ROW);
        
        [[NSUserDefaults standardUserDefaults] setObject:contArr forKey:@"ListOfContactArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //new
        [[NSUserDefaults standardUserDefaults] setObject:designationArr forKey:@"ListOfDesignArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //PersonContact
        [[NSUserDefaults standardUserDefaults] setObject:personContactArray forKey:@"PersonContactArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }
    else{
        
    }
    
   
    sqlite3_reset(selectStatement);
    sqlite3_clear_bindings(selectStatement);
    sqlite3_finalize(selectStatement);
    sqlite3_close(contactDB);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) getContactDetails
{
    [self prepareStatement];
    
    NSString *sqlString2;
    const char *sql_Stmt2;
    sqlite3_stmt *selectContact;
    
    //int rc=0;
    sqlString2 = [NSString stringWithFormat:@"SELECT imagename, designation, firstname, lastname, birthdate, contactnumber, faxnumber, emailid, companyname, website, address, city, country, postcode FROM contacts where contactnumber = ? order by firstname"];
    sql_Stmt2 = [sqlString2 UTF8String];
    sqlite3_prepare_v2(contactDB, sql_Stmt2, -1, &selectContact, NULL);
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *selCont = [prefs stringForKey:@"SelectedContact"];
    
    // NSLog(@"CDV is %@",selCont);
    
    sqlite3_bind_text(selectContact, 1, [selCont UTF8String], -1, SQLITE_TRANSIENT);
    
    if(sqlite3_step(selectContact)==SQLITE_ROW)
    {
        NSString *pDesignation=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 1)];
        NSString *fname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 2)];
        NSString *lname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 3)];
       // NSString *dob = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 4)];
        NSString *contNum = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 5)];
        NSString *faxNum = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 6)];
        NSString *email = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 7)];
        NSString *compName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 8)];
        NSString *website = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 9)];
        NSString *address = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 10)];
        NSString *city = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 11)];
        NSString *country = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 12)];
        NSString *postcode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(selectContact, 13)];
        
        NSArray *selectedContactDetails = [[NSArray alloc] initWithObjects: pDesignation,fname,lname,@"nodate",contNum,faxNum,email,compName,website,address,city,country,postcode, nil];
        NSString *totalContactDetails = [selectedContactDetails componentsJoinedByString:@"&&"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // saving an NSString
        [prefs setObject:totalContactDetails forKey:@"ContactToBeSent"];
        
    }
    
    sqlite3_finalize(selectContact);
    
    sqlite3_close(contactDB);

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
