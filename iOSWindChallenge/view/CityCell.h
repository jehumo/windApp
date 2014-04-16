//
//  CityCell.h
//  
//
//  Created by JESUS HURTADO on 15/04/14.
//
//

#import <UIKit/UIKit.h>

@interface CityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *theTitle;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@end
