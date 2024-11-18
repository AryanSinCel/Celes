//
//  DetailedProjectView.h
//  Celes
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailedProjectView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *roleTextField;
@property (weak, nonatomic) IBOutlet UITextField *competeTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addProject:(id)sender;

@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;

@property (strong,nonatomic) NSDictionary *projectDetail;

@end

NS_ASSUME_NONNULL_END
