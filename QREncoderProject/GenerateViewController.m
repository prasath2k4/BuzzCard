//
//  GenerateViewController.m
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import "GenerateViewController.h"

#import "AboutUsViewController.h"

@interface GenerateViewController ()

@end

@implementation GenerateViewController

@synthesize window;
@synthesize personDesignation,firstName,lastName,dateOfBirth,contactNumber,emailId,companyName,webUrl,streetDetails,cityName,countryName,postCode,faxNumber,myView;

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
    
    

    
}

-(BOOL)isABackSpace:(NSString*)string {
    NSString* check =@"Check";
    check = [check stringByAppendingString:string];
    if ([check isEqualToString:@"Check"]) {
        return YES;
    }
    return NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    genConArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"GenCon"]];
    
    if(![genConArray count] == 0)
    {
        
        firstName.text=genConArray[0];
        lastName.text=genConArray[1];
        personDesignation.text=genConArray[2];
        contactNumber.text=genConArray[4];
        faxNumber.text=genConArray[5];
        emailId.text=genConArray[6];
        companyName.text=genConArray[7];
        webUrl.text=genConArray[8];
        streetDetails.text=genConArray[9];
        cityName.text=genConArray[10];
        countryName.text=genConArray[11];
        postCode.text=genConArray[12];
    }
    else{
        
        firstName.text=@"";
        lastName.text=@"";
        personDesignation.text=@"";
        contactNumber.text=@"";
        faxNumber.text=@"";
        emailId.text=@"";
        companyName.text=@"";
        webUrl.text=@"";
        streetDetails.text=@"";
        cityName.text=@"";
        countryName.text=@"";
        postCode.text=@"";
        
    }
}


-(void) createBuzzContact
{
    /*
    if(![webUrl.text hasPrefix:@"www."])
    {
        NSString *url = @"www.";
        NSString *finalUrl = [url stringByAppendingString:webUrl.text];
        webUrl.text = finalUrl;
    }
     */
    
    /////
    
    
    
    /////
    
    contactArray = [[NSMutableArray alloc] initWithObjects: firstName.text,lastName.text,personDesignation.text,@"nodate",contactNumber.text,faxNumber.text,emailId.text,companyName.text,webUrl.text,streetDetails.text,cityName.text,countryName.text,postCode.text, nil];
    NSString *finalContact = [contactArray componentsJoinedByString:@"|"];
    
    [[NSUserDefaults standardUserDefaults] setObject:contactArray forKey:@"GenCon"];

    
    
    /////
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:finalContact forKey:@"ContactToAppend"];
    
    [prefs setObject:contactNumber.text forKey:@"ContactToSearch"];
    
    ////
    
   // CreatedQRViewController *createQR = [[CreatedQRViewController alloc] initWithNibName:@"CreatedQRViewController" bundle:nil];
   // createQR.contact = finalContact;
    
   // UIImage *image1 = [createQR quickResponseImageForString:finalContact withDimension:182];
    
  //  [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image1) forKey:@"MyQR1"];
    
    //[self presentViewController:createQR animated:YES completion:nil];
    
    ////
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefsCont setObject:contactNumber.text forKey:@"MyContactNumber"];
    
    /////
    
    UIAlertView *alertPopUp = [[UIAlertView alloc] initWithTitle:@"Alert"
                               
                                                         message:@"Your contact is created"
                               
                                                        delegate:self cancelButtonTitle:@"OK"
                               
                                               otherButtonTitles:nil];
    
    [alertPopUp show];

    
    //AboutUsViewController *about = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUs"];
    
    //[self presentViewController:about animated:YES completion:nil];
    
    }

- (void)viewDidLoad
{
    
    [self.view endEditing:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    self.myView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slate.PNG"]];
    
    //
    
    personDesignation.delegate=self;
    firstName.delegate=self;
    lastName.delegate=self;
    contactNumber.delegate=self;
    emailId.delegate=self;
    companyName.delegate=self;
    webUrl.delegate=self;
    streetDetails.delegate=self;
    cityName.delegate=self;
    countryName.delegate=self;
    postCode.delegate=self;
    faxNumber.delegate=self;
    
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [personDesignation resignFirstResponder];
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [contactNumber resignFirstResponder];
    [emailId resignFirstResponder];
    [companyName resignFirstResponder];
    [webUrl resignFirstResponder];
    [streetDetails resignFirstResponder];
    [cityName resignFirstResponder];
    [countryName resignFirstResponder];
    [postCode resignFirstResponder];
    [faxNumber resignFirstResponder];

    
    return  YES;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
