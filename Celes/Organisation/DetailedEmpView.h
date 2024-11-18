//
//  DetailedEmpView.h
//  Celes
//
//  Created by Celestial on 08/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailedEmpView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *contactTextField;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *email;

- (IBAction)sendMessage:(id)sender;


@end

NS_ASSUME_NONNULL_END
