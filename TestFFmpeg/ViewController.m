//
//  ViewController.m
//  TestFFmpeg
//
//  Created by qianpanpan on 2020/3/11.
//  Copyright © 2020 MengLA. All rights reserved.
//

#import "ViewController.h"
#import "avformat.h"
#import "avcodec.h"
#import "avfilter.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    av_register_all();
    char info[10000] = {0};
    printf("%s\n",avcodec_configuration());
    sprintf(info,"%s\n", avcodec_configuration());
    NSString *info_ns = [NSString stringWithFormat:@"%s",info];
    NSLog(@"%@",info_ns);
}

- (IBAction)clickProtocol:(id)sender {
    char info[40000] = {0};
    av_register_all();
    struct URLProtocol *pup = NULL;
    struct URLProtocol **p_temp = &pup;
    avio_enum_protocols((void **)p_temp, 0);
    while ((*p_temp) != NULL) {
        sprintf(info, "%s[IN ][%10s]\n",info,avio_enum_protocols((void **)p_temp, 0));
    }
    pup = NULL;
    avio_enum_protocols((void **)p_temp, 1);
    while ((*p_temp)!=NULL) {
        sprintf(info, "%s[Out][%10s]\n",info,avio_enum_protocols((void **)p_temp, 1));
    }
    NSString *info_ns = [NSString stringWithFormat:@"%s",info];
    self.textView.text = info_ns;
}

- (IBAction)clickAVFormat:(id)sender {
    char info[40000] = { 0 };
    
    av_register_all();
    
    AVInputFormat *if_temp = av_iformat_next(NULL);
    AVOutputFormat *of_temp = av_oformat_next(NULL);
    //Input
    while(if_temp!=NULL){
        sprintf(info, "%s[In ]%10s\n", info, if_temp->name);
        if_temp=if_temp->next;
    }
    //Output
    while (of_temp != NULL){
        sprintf(info, "%s[Out]%10s\n", info, of_temp->name);
        of_temp = of_temp->next;
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.textView.text=info_ns;
    
}

- (IBAction)clickAVCodec:(id)sender {
    char info[40000] = {0};
    av_register_all();
    AVCodec *c_temp = av_codec_next(NULL);
    while (c_temp!=NULL) {
        if (c_temp->decode!=NULL) {
            sprintf(info, "%s[Dec]",info);
        }else{
            sprintf(info, "%s[Enc]",info);
        }
        switch (c_temp->type) {
            case AVMEDIA_TYPE_VIDEO:
                sprintf(info, "%s[Video]", info);
                break;
            case AVMEDIA_TYPE_AUDIO:
                sprintf(info, "%s[Audio]", info);
                break;
            default:
                sprintf(info, "%s[Other]", info);
                break;
        }
        sprintf(info, "%s%10s\n",info,c_temp->name);
        c_temp=c_temp->next;
    }
    NSString *info_s = [NSString stringWithFormat:@"%s",info];
           self.textView.text = info_s;
}

- (IBAction)clickAVFilter:(id)sender {
    char info[40000] = { 0 };
    avfilter_register_all();
    AVFilter *f_temp = avfilter_next(NULL);
    while (f_temp != NULL){
        sprintf(info, "%s[%10s]\n", info, f_temp->name);
        f_temp=f_temp->next;
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.textView.text=info_ns;
 
    
}

- (IBAction)clickConfigure:(id)sender {
    char info[10000] = { 0 };
    av_register_all();
    sprintf(info, "%s\n",avcodec_configuration());
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.textView.text=info_ns;
}


@end
