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
    -(void)_handleFlipButtonReleased:(id)arg1;
@end

@interface CAMApplicationDelegate : UIResponder
    @property (nonatomic,readonly) CAMViewfinderViewController * viewfinderViewController;
    -(void)flip;
@end

%group enabled
    %hook CAMApplicationDelegate
        %new
        - (void)flip
        {
            [self.viewfinderViewController _handleFlipButtonReleased:[self.viewfinderViewController _flipButton]];
        }
    %end
    %hook CAMPreviewViewController
        - (void) viewDidLoad
        {
            %orig;

            UITapGestureRecognizer *recognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];

            recognizer.numberOfTapsRequired = 2;
            [self.previewView addGestureRecognizer:recognizer];
        }
        %new
        - (void)handleTap:(UITapGestureRecognizer *)recognizer 
        {
            CAMApplicationDelegate *delegate = (CAMApplicationDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate flip];
        }
    %end
%end

%ctor 
{
    %init;
    NSDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/net.johnatkinson.tapflipprefs.plist"];
    if( settings[@"Enabled"] ? [settings[@"Enabled"] boolValue] : NO)
    {
        %init(enabled);
    }
}
