//
//  DatumViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/25.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "DatumViewController.h"
#import "TwoTableViewCell.h"
#import "HeadTableViewCell.h"
#import "DataTableViewCell.h"
#import "SexTableViewCell.h"
#import "NameTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface DatumViewController ()<pioneer_navigationControllerDelegate,UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) UITableView *bottomTB;
@property(nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) HeadTableViewCell *headCell;
@property(nonatomic, strong) NSData *fileData;
@property (strong, nonatomic) UIButton *saveBth;
@end

@implementation DatumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"个人资料";
    self.barButtonType = PioneerBarButtonTypeBack;
    self.pioneerDelegate = self;
    self.view.backgroundColor = UIColorFromRGB(0xf2f7f5);
    // Do any additional setup after loading the view.
    
    [self.pioneer_navBar addSubview:self.saveBth];
    [self.view addSubview:self.bottomTB];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _bottomTB.sd_layout.topSpaceToView(self.view, 64).leftEqualToView(self.view).rightEqualToView (self.view).heightRatioToView(self.view, 1);
    _saveBth.sd_layout.topSpaceToView(self.pioneer_navBar,10).rightSpaceToView(self.pioneer_navBar,10).widthIs(40).heightIs(20);
    
}

-(UIButton *)saveBth {
    if (!_saveBth) {
        _saveBth = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBth setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBth addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _saveBth;
}

- (void)saveAction:(UIButton *)sender {
}


- (UITableView *)bottomTB {
    if (!_bottomTB) {
        self.bottomTB = [UITableView new];
        _bottomTB.backgroundColor = UIColorFromRGB(0xf2f7f5);
        
        UINib *nib = [UINib nibWithNibName:@"TwoTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"TwoTableViewCell"];
        UINib *nib1 = [UINib nibWithNibName:@"HeadTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib1 forCellReuseIdentifier:@"HeadTableViewCell"];
        
        UINib *nib2 = [UINib nibWithNibName:@"DataTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib2 forCellReuseIdentifier:@"DataTableViewCell"];
        UINib *nib3 = [UINib nibWithNibName:@"SexTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib3 forCellReuseIdentifier:@"SexTableViewCell"];
        
        UINib *nib4 = [UINib nibWithNibName:@"NameTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib4 forCellReuseIdentifier:@"NameTableViewCell"];
        
        _bottomTB.delegate =self;
        _bottomTB.dataSource =self;
        
        
    }
    return _bottomTB;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        return 20;
    }
    else if (indexPath.row == 2){
              return 20;
    }
    else if (indexPath.row == 5) {
               return 20;
    }
    else if (indexPath.row == 1) {
        
        return 80;
    }else {
               return 50;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 2){
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 5) {
        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1) {
//        return self.headCell;
        HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell"];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 4) {
        SexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SexTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 3) {
        NameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameTableViewCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
    else {
        DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataTableViewCell"];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        /*注：使用，需要实现以下协议：UIImagePickerControllerDelegate,
         UINavigationControllerDelegate
         */
//        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
//        //设置图片源(相簿)
//        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        //设置代理
//        picker.delegate = self;
//        //设置可以编辑
//        picker.allowsEditing = YES;
//        //打开拾取器界面
//        [self presentViewController:picker animated:YES completion:nil];
//
    if (indexPath.row == 1) {
        UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择文件来源"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"照相机",@"本地相簿",nil];
        [actionSheet showInView:self.view];
        
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        

    }
    
 }

- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [%d]",buttonIndex);
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;

        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;

        default:
            break;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:image afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
    }
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
   
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];\
    
    
    //获取cell
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
    HeadTableViewCell *cell = [self.bottomTB cellForRowAtIndexPath:index];
    self.img.image = selfPhoto;
    cell.headImage.image = self.img.image;
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
