//
//  AboutUsViewController.m
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    self.myBuzz=nil;
    self.buzzScan=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CurrentLocationIdentifier]; // call this method
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slate.PNG"]];

}


-(void)CurrentLocationIdentifier
{
    NSLog(@"\nCurrent Location Detected\n");
    //---- For getting current gps location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
#ifdef __IPHONE_8_0
    NSUInteger code = [CLLocationManager authorizationStatus];
    if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
        // choose one request according to your business.
        if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
            [locationManager requestAlwaysAuthorization];
        } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
            [locationManager  requestWhenInUseAuthorization];
        } else {
            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
        }
    }
#endif
    
    [locationManager startUpdatingLocation];
    //------
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLoc = newLocation;
    latitude = [[NSNumber numberWithDouble:currentLoc.coordinate.latitude] stringValue];
    longitude = [[NSNumber numberWithDouble:currentLoc.coordinate.longitude] stringValue];
    [locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) buzzCardScan
{
    
    
    [self PostData];
    
    
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    NSString *myPhoneNum = [prefsCont stringForKey:@"ContactToSearch"];
    NSString *uploadContact = [NSString stringWithFormat:@"%@|%@|%@",myPhoneNum,latitude,longitude];
    
    NSLog(@"The lat is %@", latitude);
    NSLog(@"The lon is %@", longitude);
    
    //
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://childcare.korra1.com/public/index.php/mobileapi/GetQRData?mobile=%@",uploadContact];
    
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        // Parse data here
        //initialize convert the received data to string with UTF8 encoding
        NSString *htmlSTR = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
        NSLog(@"the new contact is %@",htmlSTR);
        
        if(![htmlSTR isEqualToString:@"no data"])
        {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:htmlSTR forKey:@"newContact"];
        

        
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tvc = [st instantiateViewControllerWithIdentifier:@"NewContactDetails"];
        [self presentViewController:tvc animated:YES completion:nil];
        
    }
    else
    {
        NSLog(@"Before sleep for 10 minutes");
        int timeInterval = [@"4" intValue];
        [self performSelector:@selector(GetPartnerData) withObject:nil afterDelay:timeInterval];
    }
    }
    
}

-(void) GetPartnerData
{
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    NSString *myPhoneNum = [prefsCont stringForKey:@"ContactToSearch"];
    NSString *uploadContact = [NSString stringWithFormat:@"%@|%@|%@",myPhoneNum,latitude,longitude];
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://childcare.korra1.com/public/index.php/mobileapi/GetQRData?mobile=%@",uploadContact];
    
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        // Parse data here
        //initialize convert the received data to string with UTF8 encoding
        NSString *htmlSTR = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
        NSLog(@"the new contact is %@",htmlSTR);
        
        //if([htmlSTR isEqualToString:@"no data"])
        if([htmlSTR caseInsensitiveCompare:@"no data"] == NSOrderedSame)
        {
            
            NSLog(@"The error is %@",[error userInfo]);
            NSLog(@"Before sleep for 10 minutes");
            int timeInterval = [@"4" intValue];
            [self performSelector:@selector(GetPartnerData) withObject:nil afterDelay:timeInterval];
        }
            else
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:htmlSTR forKey:@"newContact"];
        
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *tvc = [st instantiateViewControllerWithIdentifier:@"NewContactDetails"];
        [self presentViewController:tvc animated:YES completion:nil];
    }
            

    }
    
    
}

-(void) PostData
{
    
    //
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    NSString *myContactNumber = [prefsCont stringForKey:@"ContactToAppend"];
    NSString *myPhoneNum = [prefsCont stringForKey:@"ContactToSearch"];
    NSString *uploadContact = [NSString stringWithFormat:@"%@|%@|%@",myPhoneNum,latitude,longitude];
    NSArray *contactArray = [[NSArray alloc] initWithObjects:myContactNumber,uploadContact, nil];
    NSString *contactToSend = [contactArray componentsJoinedByString:@"|"];
    
    
   // NSString *urlString = @"http://childcare.korra1.com/public/index.php/mobileapi/SetQrData?data=first_name|last_name|designation|birth_date|contact_number|facsimile_number|email_id|company_name|website|address|city|country|postcode|83834188|1.30186160|103.86148179";
    NSString *urlString = [NSString stringWithFormat:@"http://childcare.korra1.com/public/index.php/mobileapi/SetQrData?data=%@",contactToSend];
    
    NSURLRequest * urlRequest1 = [NSURLRequest requestWithURL:[NSURL
                                                               URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSURLResponse * response1 = nil;
    NSError * error1 = nil;
    NSData * data1 = [NSURLConnection sendSynchronousRequest:urlRequest1
                                           returningResponse:&response1
                                                       error:&error1];
    
    if (error1 == nil)
    {
        // Parse data here
        //initialize convert the received data to string with UTF8 encoding
        NSString *htmlSTR1 = [[NSString alloc] initWithData:data1
                                                   encoding:NSUTF8StringEncoding];
        NSLog(@"data posted as %@",htmlSTR1);
    }
    else
    {
        NSLog(@"data posted as %@",error1);
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}


@end
