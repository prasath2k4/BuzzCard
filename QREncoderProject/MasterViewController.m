//
//  MasterViewController.m
//  ContactTesting
//
//  Created by Ramakishore Kanaparthy on 15/8/14.
//  Copyright (c) 2014 Rajeswari. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "NewContactViewController.h"

#import <Parse/Parse.h>

@interface MasterViewController () {
    NSMutableArray *_objects;
    
    
        NSArray *convertedContactArray;
        NSArray *convertedDesignationArray;
        NSArray *convertedSearchResults;
        
    
    
}
@end

@implementation MasterViewController
@synthesize contactArray,searchResults,window,designationArray,personContactArray;
@synthesize mySearchBar,myTableView,isFiltered;

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:(BOOL) animated];

    self.myTableView=nil;
    self.mySearchBar=nil;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void) goBack
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
        //[mainstoryBoard release];
        self.window.rootViewController = mainViewController;
        [self.window makeKeyAndVisible];
        
    }
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
  //  NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"cellName contains[cd] %@ AND title contains[cd] %@",searchText,searchText];

    
    
    //self.searchResults = [NSMutableArray arrayWithArray: [self.contactArray filteredArrayUsingPredicate:resultPredicate]];
    
    //name+designation
    self.searchResults = [NSMutableArray arrayWithArray: [self.personContactArray filteredArrayUsingPredicate:resultPredicate]];
    
    }

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
<<<<<<< HEAD
    NewContactViewController *cd = [[NewContactViewController alloc] init];
=======
    
    //// check this..
    
    
    NSUserDefaults *prefsCont = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *myContactNumber = [prefsCont stringForKey:@"MyContactNumber"];
    
    
    //delete query after recieving the contact
    
    PFQuery *query1= [PFQuery queryWithClassName:@"ContactExchange"];
    [query1 whereKey:@"contact_sendTo" equalTo:myContactNumber];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error)
        {
            for (PFObject *object in objects) {
                [object deleteInBackground];
            }
        }
        else
        {
            NSLog(@"error while deleting is %@",[error userInfo]);
        }
    }];
    
    
    ////
    
    
    
    ContactDetailViewController *cd = [[ContactDetailViewController alloc] init];
>>>>>>> FETCH_HEAD
    [cd findContact];
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    contactArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"ListOfContactArray"] mutableCopy];
    
    //new
    designationArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"ListOfDesignArray"] mutableCopy];
    
    personContactArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"PersonContactArray"] mutableCopy];
    
    //NSLog(@"the designation array is %@",designationArray);
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.contactArray count]];
    
    convertedContactArray = [contactArray copy];
<<<<<<< HEAD
    convertedDesignationArray = [designationArray copy];
=======
   // NSLog(@"The converted contact array is %@",convertedContactArray);
    
    
    myTableView.backgroundView =
    [[UIImageView alloc]initWithImage:
     [[UIImage imageNamed:@"retina_wood.png"] stretchableImageWithLeftCapWidth:0.0
                                                                 topCapHeight:5.0]];
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"retina_wood.png"]];
    
       

    
>>>>>>> FETCH_HEAD
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        // NSArray *sourceArray;
        NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:(UITableViewCell *)sender];
        
        if (indexPath != nil)
        {
          //  sourceArray = self.searchResults;
            
        }
        else
        {
           // indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
           // sourceArray = self.contactArray;
           
        }
       // [sourceArray release];

    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    else
    {
        return [self.contactArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        //cell.textLabel.numberOfLines=0;
        //cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        //cell.detailTextLabel.text = self.designationArray[indexPath.row];
        //cell.detailTextLabel.text = @"";
        // [cell.detailTextLabel setHidden:YES];
        
        ///
        
        NSString *selCell = [self.searchResults objectAtIndex:indexPath.row];

        NSArray *testArray = [[NSArray alloc] init];
        
        testArray = [selCell componentsSeparatedByString:@"\r"];
        
        NSString *text1 = [testArray objectAtIndex:0];
        NSString *text2 = [testArray objectAtIndex:1];
        NSString *text3 = [testArray objectAtIndex:2];
        
        cell.textLabel.numberOfLines=0;
        cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",text1,text2];
        cell.detailTextLabel.text=text3;
        [cell.detailTextLabel setHidden:YES];
        
        
        ///


    }
    else
    {
       // cell.textLabel.text = self.contactArray[indexPath.row];
       // cell.detailTextLabel.text = self.designationArray[indexPath.row];
       
        
        
        NSString *testText = self.personContactArray[indexPath.row];

        
        NSArray *testArray = [[NSArray alloc] init];
        
        testArray = [testText componentsSeparatedByString:@"\r"];
        
        NSString *text1 = [testArray objectAtIndex:0];
        NSString *text2 = [testArray objectAtIndex:1];
        NSString *text3 = [testArray objectAtIndex:2];
                
     //   NSLog(@"the final text is %@",finalText);
        cell.textLabel.numberOfLines=0;
        cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",text1,text2];
        cell.detailTextLabel.text=text3;
        [cell.detailTextLabel setHidden:YES];
         
    
        
      //  cell.textLabel.numberOfLines=0;
      //  cell.textLabel.text = self.personContactArray[indexPath.row];
       // cell.detailTextLabel.text = self.designationArray[indexPath.row];
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *cellLabelText = cell.textLabel.text;
    
    /*
    
    NSArray *sepArray = [[NSArray alloc] init];
    
    sepArray = [cellLabelText componentsSeparatedByString:@"\t"];
    
    NSString *num = [sepArray objectAtIndex:2];
    
    NSArray *sepNum = [[NSArray alloc] init];
    
    sepNum = [num componentsSeparatedByString:@"\r"];
    
    NSString *finalNum = [sepNum objectAtIndex:1];
    
     */
    
    NSLog(@"The selected contact is %@",cell.detailTextLabel.text);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:cell.detailTextLabel.text forKey:@"SelectedContact"];
    
    [myTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
