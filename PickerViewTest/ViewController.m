//
//  ViewController.m
//  PickerViewTest
//
//  Created by oc on 5/22/13.
//  Copyright (c) 2013 oc. All rights reserved.
//

#import "ViewController.h"
#define FirstComponent 0
#define SubComponent 1
#define ThirdComponent 2
@interface ViewController ()
@property(nonatomic,retain)NSDictionary* dict;
@property(nonatomic,retain)NSArray* pickerArray;
@property(nonatomic,retain)NSArray* subPickerArray;
@property(nonatomic,retain)NSArray* thirdPickerArray;
@property(nonatomic,retain)NSArray* selectArray;
@end

@implementation ViewController
@synthesize dict=_dict;
@synthesize pickerArray=_pickerArray;
@synthesize subPickerArray=_subPickerArray;
@synthesize thirdPickerArray=_thirdPickerArray;
@synthesize selectArray=_selectArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    _dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerArray=[_dict allKeys];
    self.selectArray=[_dict objectForKey:[[_dict allKeys] objectAtIndex:0]];
    if ([_selectArray count]>0) {
        self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
    }
    if ([_subPickerArray count]>0) {
        self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark--UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return [self.pickerArray count];
    }
    if (component==SubComponent) {
        return [self.subPickerArray count];
    }
    if (component==ThirdComponent) {
        return [self.thirdPickerArray count];
    }
    return 0;
}


#pragma mark--
#pragma mark--UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return [self.pickerArray objectAtIndex:row];
    }
    if (component==SubComponent) {
        return [self.subPickerArray objectAtIndex:row];
    }
    if (component==ThirdComponent) {
        return [self.thirdPickerArray objectAtIndex:row];
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"row is %d,Component is %d",row,component);
    if (component==0) {
        self.selectArray=[_dict objectForKey:[self.pickerArray objectAtIndex:row]];
        if ([self.selectArray count]>0) {
            self.subPickerArray= [[self.selectArray objectAtIndex:0] allKeys];
        }else{
            self.subPickerArray=nil;
        }
        if ([self.subPickerArray count]>0) {
            self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:0]];
        }else{
            self.thirdPickerArray=nil;
        }
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:2];
        
        
    }
    if (component==1) {
        if ([_selectArray count]>0&&[_subPickerArray count]>0) {
            self.thirdPickerArray=[[self.selectArray objectAtIndex:0] objectForKey:[self.subPickerArray objectAtIndex:row]];
        }else{
            self.thirdPickerArray=nil;
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    
    
    [pickerView reloadComponent:2];
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==FirstComponent) {
        return 90.0;
    }
    if (component==SubComponent) {
        return 120.0;
    }
    if (component==ThirdComponent) {
        return 100.0;
    }
    return 0;
}
-(void)dealloc
{
   self.dict=nil;
   self.pickerArray=nil;
   self.subPickerArray=nil;
   self.thirdPickerArray=nil;
    self.selectArray=nil;
    [super dealloc];
}
@end
