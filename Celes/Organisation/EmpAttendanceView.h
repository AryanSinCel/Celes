//
//  EmpAttendanceView.h
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmpAttendanceView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSMutableArray *attendace;



@end

NS_ASSUME_NONNULL_END
