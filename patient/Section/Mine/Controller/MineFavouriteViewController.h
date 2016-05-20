//
//  MineFavouriteViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "YJSegmentedControl.h"

@interface MineFavouriteViewController : BaseViewController<YJSegmentedControlDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic)NSInteger favouriteType;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;
@property (assign,nonatomic)BOOL flag3;
@property (assign,nonatomic)BOOL flag4;

@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UITableView *tableView1;
@property (strong,nonatomic)UITableView *tableView2;
@property (strong,nonatomic)UITableView *tableView3;
@property (strong,nonatomic)UITableView *tableView4;

@property (strong,nonatomic)NSMutableArray *favouriteAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishTypeAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishIdAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishImageAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishNameAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishPropertyAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishFunctionAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishCommentAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodTypeAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodIdAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodImageAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodNameAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodPropertyAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodSeasonAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodCommentAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseIdAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseNameAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseDetailAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseSymptomAllArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseCauseAllArray;

@property (strong,nonatomic)NSMutableArray *favouriteDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishTypeDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishIdDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishImageDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishNameDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishPropertyDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishFunctionDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishCommentDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodTypeDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodIdDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodImageDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodNameDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodPropertyDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodSeasonDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodCommentDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseIdDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseNameDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseDetailDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseSymptomDishArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseCauseDishArray;

@property (strong,nonatomic)NSMutableArray *favouriteFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishTypeFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishIdFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishImageFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishNameFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishPropertyFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishFunctionFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishCommentFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodTypeFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodIdFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodImageFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodNameFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodPropertyFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodSeasonFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodCommentFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseIdFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseNameFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseDetailFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseSymptomFoodArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseCauseFoodArray;

@property (strong,nonatomic)NSMutableArray *favouriteDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishTypeDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishIdDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishImageDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishNameDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishPropertyDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishFunctionDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDishCommentDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodTypeDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodIdDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodImageDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodNameDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodPropertyDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodSeasonDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteFoodCommentDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseIdDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseNameDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseDetailDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseSymptomDiseaseArray;
@property (strong,nonatomic)NSMutableArray *favouriteDiseaseCauseDiseaseArray;

@end
