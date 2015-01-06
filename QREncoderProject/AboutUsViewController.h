//
//  AboutUsViewController.h
//  QREncoderProject
//
//  Created by Ramakishore Kanaparthy on 9/8/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AboutUsViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *latitude;
    NSString *longitude;
}

@property (weak, nonatomic) IBOutlet UIButton *myBuzz;
@property (weak, nonatomic) IBOutlet UIButton *buzzScan;

-(IBAction) myBuzzCard;
-(IBAction) buzzCardScan;
@end
