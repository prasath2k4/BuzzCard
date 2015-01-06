//
//  DetailViewController.m
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import "DetailViewController.h"
#import "NewContactViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize profilePic,imageName,detailDescriptionLabel,personAddress,personContactNum,personCity,personFullName,personCompanyName,personCountry,personDOB,personEmailID,personPostCode,personDesign,personWebsite,personFaxNum;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


//

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:(BOOL) animated];

    self.detailDescriptionLabel=nil;
    self.personDesign = nil;
    self.personFullName = nil;
    self.personDOB = nil;
    self.personContactNum = nil;
    self.personFaxNum = nil;
    self.personEmailID = nil;
    self.personCompanyName = nil;
    self.personWebsite= nil;
    self.personAddress = nil;
    self.personCity=nil;
    self.personCountry=nil;
    self.personPostCode=nil;
}

//

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft]
                                forKey:@"orientation"];
    ///
    
   // NSArray *personName = [[NSArray alloc] init];
    NSArray *personName;
    personName = [self.personFullName.text componentsSeparatedByString:@" "];
    personFirstName = [personName objectAtIndex:0];
    personLastName = [personName objectAtIndex:1];
    
    NSArray *editContactData = [[NSArray alloc] initWithObjects:personFirstName,personLastName,self.personDesign.text,@"nodate",self.personContactNum.currentTitle,self.personFaxNum.currentTitle,self.personEmailID.currentTitle,self.personCompanyName.text,self.personWebsite.currentTitle,self.personAddress.text,self.personCity.text,self.personCountry.text,self.personPostCode.text,nil];
    
    
    NSString *finalEditContactData = [editContactData componentsJoinedByString:@"|"];
    NSUserDefaults *editPrefs = [NSUserDefaults standardUserDefaults];
    [editPrefs setObject:finalEditContactData forKey:@"newContact"];
    
    ///


}

- (void)viewDidLoad
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft]
                                forKey:@"orientation"];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
    
    NewContactViewController *cdv = [[NewContactViewController alloc] init];
    [cdv getContactDetails];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *selCont = [prefs stringForKey:@"ContactToBeSent"];
   // NSLog(@"The selected contact is %@",selCont);
   
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
    
    dispatch_async(queue, ^{
    
    NSArray *finalContact = [selCont componentsSeparatedByString:@"&&"];
   
        dispatch_sync(dispatch_get_main_queue(), ^{
   
    self.personDesign.text=finalContact[0];
    self.personDesign.adjustsFontSizeToFitWidth = YES;
   // [self.persontitle adjustsFontSizeToFitWidth];
   // [self.persontitle sizeToFit];
    
    self.personFullName.text=finalContact[1];
    self.personFullName.adjustsFontSizeToFitWidth = YES;
    //[self.personFirstName adjustsFontSizeToFitWidth];
    //[self.personFirstName sizeToFit];
            
            
            
    
    
    self.personFullName.text = finalContact[1];
    
    self.personDOB.text=finalContact[3];
    
    [self.personContactNum setTitle:finalContact[4] forState:UIControlStateNormal];
    [self.personFaxNum setTitle:finalContact[5] forState:UIControlStateNormal];
    
    NSString *eid;
    eid = [finalContact[6] lowercaseString];
    [self.personEmailID setTitle:eid forState:UIControlStateNormal];
    
    
    self.personCompanyName.text=finalContact[7];
    
    NSString *site;
    site = [finalContact[8] lowercaseString];
   // NSString *website=@"www.";
   // site = [website stringByAppendingString:site];
    [self.personWebsite setTitle:site forState:UIControlStateNormal];
    
    self.personAddress.text=finalContact[9];
    self.personCity.text=finalContact[10];
    self.personCountry.text=finalContact[11];
    self.personPostCode.text=finalContact[12];
    
    NSString *contNumString = [self.personContactNum titleForState:UIControlStateNormal];
    NSArray *myStrings = [[NSArray alloc] initWithObjects:self.personFullName.text , contNumString, nil];
    
    imageName = [myStrings componentsJoinedByString:@"|"];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:imageName];
    self.profilePic.image = [UIImage imageWithData:imageData];
        });
    });
    
    /*
    NSArray *personName = [[NSArray alloc] init];
    personName = [self.personFullName.text componentsSeparatedByString:@" "];
    personFirstName = [personName objectAtIndex:0];
    personLastName = [personName objectAtIndex:1];
    
    NSArray *editContactData = [[NSArray alloc] initWithObjects:personFirstName,personLastName,self.personDesign.text,@"",self.personContactNum.currentTitle,self.personFaxNum.currentTitle,self.personEmailID.currentTitle,self.personCompanyName.text,self.personWebsite.currentTitle,self.personAddress.text,self.personCity.text,self.personCountry.text,self.personPostCode.text,nil];
    
    
    NSString *finalEditContactData = [editContactData componentsJoinedByString:@"|"];
    NSUserDefaults *editPrefs = [NSUserDefaults standardUserDefaults];
    [editPrefs setObject:finalEditContactData forKey:@"newContact"];

    */
    
}

-(void) openWebpage
{
    NSString* launchUrl = [@"http://" stringByAppendingString:self.personWebsite.currentTitle];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
    
}

-(void) makeCall
{
    NSString *numToCall=[@"tel:" stringByAppendingString:self.personContactNum.currentTitle];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numToCall]];
}

-(void) sendEmail
{
 //   NSString *emailTitle = @"";
    // Email Content
   // NSString *messageBody = @"";
    // To address
   // NSArray *toRecipents = [NSArray arrayWithObject:self.personContactNum];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    //[mc setSubject:emailTitle];
    //[mc setMessageBody:messageBody isHTML:NO];
    NSArray *toArray = [self.personEmailID.currentTitle componentsSeparatedByString:@""];
    [mc setToRecipients:toArray];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
          //  NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
           // NSLog(@"Mail not sent.");
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)saveContactToLocal
{
    
    alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                               
                                                         message:@"Do you want to save the contact to phone?"
                               
                                                        delegate:self cancelButtonTitle:@"Yes"
                               
                                               otherButtonTitles:@"No", nil];
    
    [alertPopUp show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
        
    {
        
        [self contactSync];
    }
    
    if (buttonIndex == 1)
        
    {
        alertPopUp=nil;
    }
    
}


-(void) contactSync
{

    CFErrorRef error = nil;
    
    
    
    //creating address book
    
    ABAddressBookRef iPhoneAdrsBookRef = ABAddressBookCreateWithOptions(Nil,Nil);
    
    
    
    __block BOOL accessGranted = NO;
    
    
    
    //checking for access
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(iPhoneAdrsBookRef, ^(bool granted, CFErrorRef error) {
            
            accessGranted = granted;
            
            dispatch_semaphore_signal(sema);
            
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        //  dispatch_release(sema);
        
    }
    
    else { // we're on iOS 5 or older
        
        accessGranted = YES;
        
    }
    
    
    
    if(accessGranted)
        
    {
        
        ABRecordRef newPerson = ABPersonCreate();
        
        
        
        //firstname
        
        ABRecordSetValue(newPerson, kABPersonFirstNameProperty,CFBridgingRetain(personFirstName), &error);
        
        
        
        //lastname
        
        ABRecordSetValue(newPerson, kABPersonLastNameProperty,CFBridgingRetain(personLastName), &error);
        
        
        
        //company name
        
        ABRecordSetValue(newPerson, kABPersonOrganizationProperty,CFBridgingRetain(personCompanyName.text), &error);
        
        
        
        //designation
        
        ABRecordSetValue(newPerson, kABPersonJobTitleProperty,CFBridgingRetain(personDesign.text), &error);
        
        
        //phone num and fax number
        
        ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        ABMultiValueAddValueAndLabel(multiPhone, CFBridgingRetain(personContactNum.currentTitle), kABPersonPhoneMobileLabel, NULL);
        
        ABMultiValueAddValueAndLabel(multiPhone,CFBridgingRetain(personFaxNum.currentTitle), kABOtherLabel, NULL);
        
        ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,nil);
        
        // release phone object
        
        CFRelease(multiPhone);
        
        
        
        //Adding email details
        
        ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        // set the work mail
        
        ABMultiValueAddValueAndLabel(multiEmail,CFBridgingRetain(personEmailID.currentTitle), kABWorkLabel, NULL);
        
        // add the mail to person
        
        ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, &error);
        
        // release mail object
        
        CFRelease(multiEmail);
        
        
        
        //add website
        
        ABMutableMultiValueRef urlMultiValue =
        
        ABMultiValueCreateMutable(kABStringPropertyType);
        
        ABMultiValueAddValueAndLabel(urlMultiValue, CFBridgingRetain(personWebsite.currentTitle),
                                     
                                     kABPersonHomePageLabel, NULL);
        
        ABRecordSetValue(newPerson, kABPersonURLProperty, urlMultiValue, &error);
        
        CFRelease(urlMultiValue);
        
        
        
        //// adding address details
        
        // create address object
        
        ABMutableMultiValueRef multiAddress = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
        
        // create a new dictionary
        
        NSMutableDictionary *addressDictionary = [[NSMutableDictionary alloc] init];
        
        // set the address line to new dictionary object
        
        [addressDictionary setObject:personAddress.text forKey:(NSString *) kABPersonAddressStreetKey];
        
        // set the city to new dictionary object
        
        [addressDictionary setObject:personCity.text forKey:(NSString *)kABPersonAddressCityKey];
        
        // set the country to new dictionary object
        
        [addressDictionary setObject:personCountry.text forKey:(NSString *)kABPersonAddressCountryKey];
        
        // set the zip/pin to new dictionary object
        
        [addressDictionary setObject:personPostCode.text forKey:(NSString *)kABPersonAddressZIPKey];
        
        // retain the dictionary
        
        CFTypeRef ctr = CFBridgingRetain(addressDictionary);
        
        // copy all key-values from ctr to Address object
        
        ABMultiValueAddValueAndLabel(multiAddress,ctr, kABWorkLabel, NULL);
        
        // add address object to person
        
        ABRecordSetValue(newPerson, kABPersonAddressProperty, multiAddress,&error);
        
        // release address object
        
        CFRelease(multiAddress);
        
        
        
        ABAddressBookAddRecord(iPhoneAdrsBookRef, newPerson, &error);
        
        // save/commit entry
        
        ABAddressBookSave(iPhoneAdrsBookRef, &error);
        
        
        CFRelease(newPerson);
        
        if (error != NULL) {
            
            NSLog(@"error is %@",error);
            
            
        }
        
        else{
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@""
                                                                  message:@"Contact saved to phone"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
        }
        
    }
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
