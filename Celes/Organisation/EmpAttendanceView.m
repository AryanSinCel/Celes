//
//  EmpAttendanceView.m
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import "EmpAttendanceView.h"
#import "CoreData/CoreData.h"
#import "../CoreDataManager.h"



@interface EmpAttendanceView ()

@end

@implementation EmpAttendanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    if(self.id && self.email){
        NSLog(@"Employee id : %@ and email : %@",self.id,self.email);
        NSManagedObjectContext *context = [[CoreDataManager sharedManager]manageobjectcontext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Attendance"];
        request.predicate = [NSPredicate predicateWithFormat:@"id == %@ AND email == %@",self.id,self.email];
        NSError *error;
        self.attendace = [[context executeFetchRequest:request error:&error]mutableCopy];
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.attendace.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSManagedObject *attendance = [self.attendace objectAtIndex:indexPath.row];
    
    // Retrieve the date from Core Data
    NSDate *date = [attendance valueForKey:@"date"];
    
    // Format the date to display only the date part
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Convert date to a string
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    // Set cell text to the formatted date string
    cell.textLabel.text = dateString;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Check-In : %@ | Check-Out : %@",[attendance valueForKey:@"checkin"],[attendance valueForKey:@"checkout"]];
    
    // Set the background color to clear for both cell and content view
    cell.backgroundColor = UIColor.clearColor;
    cell.contentView.backgroundColor = UIColor.clearColor;
    
    // Optionally, disable the selection color
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
