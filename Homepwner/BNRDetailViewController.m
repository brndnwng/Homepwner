//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Brandon Wong on 5/17/14.
//  Copyright (c) 2014 Brandomination. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
- (IBAction)backgroundTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BNRDetailViewController

- (IBAction)clearPicture:(id)sender {
     [[BNRImageStore sharedStore] deleteImageForKey:self.item.itemKey];
    self.imageView.image = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //bronze
    imagePicker.allowsEditing=YES;
    
    imagePicker.delegate = self;
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // You need an NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    
    // Get the image for its image key from the image store
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    // Use that image to put on the screen in the imageView
    self.imageView.image = imageToDisplay;
    
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.valueField resignFirstResponder];
}

- (void)imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image;
    
    //bronze
    if(info[UIImagePickerControllerEditedImage]){
        image = info[UIImagePickerControllerEditedImage];
    }
    else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    // Store the image in the BNRImageStore for this key
        [[BNRImageStore sharedStore] setImage:image
                                       forKey:self.item.itemKey];
    
    // Put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];

    //bronze
}
@end
