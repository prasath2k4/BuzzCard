//
//  MasterViewController.h
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong,nonatomic) NSMutableArray *contactArray;

//new
@property (strong,nonatomic) NSMutableArray *designationArray;

//name+designation
@property (strong,nonatomic) NSArray *personContactArray;

@property (strong,nonatomic) NSMutableArray *searchResults;

@property (strong, nonatomic) UIWindow *window;
-(IBAction)goBack;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property BOOL isFiltered;

@end
