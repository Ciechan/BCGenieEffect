//
//  ViewController.m
//  BCGenieEffect
//
//  Created by Bartosz Ciechanowski on 10.12.2012.
//  Copyright (c) 2012 Bartosz Ciechanowski. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"
#import "UIView+Genie.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIView *boundingBox;
@property (weak, nonatomic) IBOutlet UIView *draggedView;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (nonatomic) BOOL viewIsIn;
@end

@implementation ViewController


- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{    
    NSTimeInterval duration = self.durationSlider.value;
    
    CGRect endRect = CGRectInset(rect, 5.0, 5.0);

    [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.enabled = NO;
    }];
    
    CGFloat draggedViewAlpha = 0.6;
    if (self.viewIsIn) {
        self.draggedView.alpha = 1.0; // to make fully visible screenshot
        [self.draggedView genieOutTransitionWithDuration:duration startRect:endRect startEdge:edge prepeare:^(UIView *containerView) {
            containerView.alpha = draggedViewAlpha;
        } alongsideAnimations:^(UIView *containerView) {
            [UIView animateWithDuration:duration animations:^{
                containerView.alpha = 1.0;
            }];
        } completion:^{
            self.draggedView.userInteractionEnabled = YES;
            [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                button.enabled = YES;
            }];
        }];
    } else {
        self.draggedView.userInteractionEnabled = NO;
        self.draggedView.alpha = 1.0; // to make fully visible screenshot
        [self.draggedView genieInTransitionWithDuration:duration destinationRect:endRect destinationEdge:edge prepeare:^(UIView *containerView) {
            containerView.alpha = 1.0;
        } alongsideAnimations:^(UIView *containerView) {
            [UIView animateWithDuration:duration animations:^{
                containerView.alpha = draggedViewAlpha;
            }];
        } completion:^{
            self.draggedView.alpha = draggedViewAlpha; // shoul be semi-transparent after animation.
            [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                button.enabled = YES;
            }];
         }];
    }
    
    self.viewIsIn = ! self.viewIsIn;
}


- (IBAction)bottomButtonTapped:(UIButton *)sender
{
    [self genieToRect:sender.frame edge:BCRectEdgeBottom];
}

- (IBAction)rightButtonTapped:(UIButton *)sender
{
    [self genieToRect:sender.frame edge:BCRectEdgeRight];
}

- (IBAction)leftButtonTapped:(UIButton *)sender
{
    [self genieToRect:sender.frame edge:BCRectEdgeLeft];
}

- (IBAction)topButtonTapped:(UIButton *)sender
{
    [self genieToRect:sender.frame edge:BCRectEdgeTop];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender
{
    if (self.viewIsIn) {
        return;
    }
    
    CGPoint translation = [sender translationInView:self.view];
    
    CGRect bbFrame = self.boundingBox.frame;
    CGRect frame = self.draggedView.frame;
    frame.origin.x += translation.x;
    frame.origin.y += translation.y;
    
    frame.origin.x = MAX(CGRectGetMinX(bbFrame), MIN(frame.origin.x, CGRectGetMaxX(bbFrame) - frame.size.width));
    frame.origin.y = MAX(CGRectGetMinY(bbFrame), MIN(frame.origin.y, CGRectGetMaxY(bbFrame) - frame.size.height));
    
    self.draggedView.frame = frame;
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void)viewDidUnload
{
    [self setDraggedView:nil];
    [self setDurationSlider:nil];
    [self setButtons:nil];
    [self setBoundingBox:nil];
    [super viewDidUnload];
}
@end
