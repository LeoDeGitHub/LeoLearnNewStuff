//
//  CLAliyunTestViewController.m
//  LearnNewStuff
//
//  Created by Leo on 16/8/19.
//  Copyright © 2016年 Leo. All rights reserved.
//


#import "CLAliyunTestViewController.h"
#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>
#import <Masonry.h>

/**
 String  appId = "zavtROBgB21EHUxb";
 String appKey = "GLM7kLmTa9ItdysYAbn3PGXHzMbs9G";
 
 String categoryDir = "logs";
 String fileName1 = UUID.randomUUID().toString() +".jpg";
 String relativePath = categoryDir + "/"+ fileName1;
 String bucketString = "ql-res";
 
 String result = relativePath;
 System.out.println("http://img.qlchat.com/"+result);
 
 */

NSString * const AccessKey = @"zavtROBgB21EHUxb";
NSString * const SecretKey = @"GLM7kLmTa9ItdysYAbn3PGXHzMbs9G";
NSString * const endPoint = @"http://oss-cn-hangzhou.aliyuncs.com";

@interface CLAliyunTestViewController ()<UIImagePickerControllerDelegate>

@property(strong,nonatomic) OSSClient * client;

@end

@implementation CLAliyunTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [OSSLog enableLog];
    
    [self initOSSClient];
    
    [self setupImagePickButton];
    
}

-(NSString*)genUUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}

-(NSString*)getTimeAndRandom{
    int iRandom=arc4random();
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    
    NSDateFormatter *tFormat = [[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d",[tFormat stringFromDate:[NSDate date]],iRandom];
    return tResult;
}

-(void)setupImagePickButton{
    UIButton * btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, ([UIScreen mainScreen].bounds.size.height - 50)/2, 100, 50);
    [btn addTarget:self action:@selector(addIcon) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"选择照片" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

-(void)addIcon{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action01 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    
    UIAlertAction *action02 = [UIAlertAction actionWithTitle:@"选择本地照片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *action03 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
    }];
    
    [alertController addAction:action01];
    [alertController addAction:action02];
    [alertController addAction:action03];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate方法

#pragma mark - 上传图片到服务器

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    NSLog(@"%@",info);
    UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    NSString * imageURL = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSData * imageData = UIImagePNGRepresentation(editedImage);
    
//    NSString * uuid = [self genUUID];
//    NSLog(@"uuid:%@",uuid);
    //生成24位随机字符串：当前时间+arc4random()
    NSString * timeRandomString = [self getTimeAndRandom];
    
    //异步上传图片
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    NSString * categoryDir = @"logs";
    NSString * fileName = [NSString stringWithFormat:@"%@.png",timeRandomString];
    NSString * relativePath = [NSString stringWithFormat:@"%@/%@",categoryDir,fileName];
    NSLog(@"relativePath:%@",relativePath);
    // required fields
    put.bucketName = @"ql-res";
    put.objectKey = relativePath;
     //从文件上传时，通过这个字段设置
//    put.uploadingFileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"itunes" ofType:@"png"]];
    //从内存中的NSData上传时，通过这个字段设置
    put.uploadingData = imageData;
    
    // optional fields
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    put.contentType = @"";
    put.contentMd5 = @"";
    put.contentEncoding = @"";
    put.contentDisposition = @"";
    
    OSSTask * putTask = [_client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
            [picker dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
        return nil;
    }];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)initOSSClient {
    
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey
                                                                                                            secretKey:SecretKey];
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    _client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
}



@end
