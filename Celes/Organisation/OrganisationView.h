//
//  OrganisationView.h
//  Celes
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrganisationView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)NSString *id;
@property (strong,nonatomic)NSString *email;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(strong,nonatomic) NSMutableArray *empArray;
- (IBAction)signOut:(id)sender;

@end

NS_ASSUME_NONNULL_END
