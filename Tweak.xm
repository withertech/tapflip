#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CAMPreviewView : UIView
@end

@interface CAMFlipButton : UIButton
@end

@interface CAMPreviewViewController : UIViewController
@property (nonatomic,readonly) CAMPreviewView * previewView;
@end

@interface CAMViewfinderViewController : UIViewController
-(CAMFlipButton *)_flipButton;
-(void)_handleFlipButtonReleased:(id)arg1 ;
@end

@interface CAMApplicationDelegate : UIResponder
@property (nonatomic,readonly) CAMViewfinderViewController * viewfinderViewController;
-(void)flip;
@end



%hook CAMApplicationDelegate

%new
- (void)flip{
    [self.viewfinderViewController _handleFlipButtonReleased:[self.viewfinderViewController _flipButton]];
}


%end


%hook CAMPreviewViewController
// Hooking an instance method with no arguments.
- (void) viewDidLoad{
        %orig;

         UITapGestureRecognizer *recognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleTap:)];

recognizer.numberOfTapsRequired = 2;
[self.previewView addGestureRecognizer:recognizer];
}
%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to say hello?"
    //                                             message:@"More info..."
    //                                             delegate:self
    //                                             cancelButtonTitle:@"Cancel"
    //                                             otherButtonTitles:@"Say Hello",nil];
    // [alert show];
    CAMApplicationDelegate *delegate = (CAMApplicationDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate flip];


}
%end
