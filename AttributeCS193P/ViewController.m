//
//  ViewController.m
//  AttributeCS193P
//
//  Created by Yan Zverev on 8/9/13.
//  Copyright (c) 2013 Yan Zverev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;

@end

@implementation ViewController


- (IBAction)changeFont:(UIButton *)sender {
    
    //Will get the attributes from the selected word's first letter
    CGFloat fontSize = [UIFont systemFontSize];
    NSRange range = [[self.mainTextLabel.attributedText string]rangeOfString:[self selectedWord]];
    if (range.location !=NSNotFound) {
        NSDictionary *attributes = [self.mainTextLabel.attributedText attributesAtIndex:range.location effectiveRange:NULL];
        UIFont *existingfont = attributes[NSFontAttributeName];
        if (existingfont) {
            fontSize = existingfont.pointSize;
        }
    }
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{NSFontAttributeName:font}];
    
}
- (IBAction)setOutline:(id)sender {
    
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName : @5}];
     
}
- (IBAction)setNoOutline:(id)sender {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName : @0}];

}

- (IBAction)changeColor:(UIButton *)sender {
    
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName:sender.backgroundColor}];
}

- (IBAction)underLine:(id)sender {
    
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
}

- (IBAction)unUnderLine:(id)sender {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)}];
    
}

- (IBAction)outlineAndFill
{
    [self addSelectedWordAttributes:@{ NSStrokeWidthAttributeName : @-5,  // stroke and fill
        NSStrokeColorAttributeName : [UIColor blackColor] }];
}




-(void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.mainTextLabel.attributedText string]rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];

}

-(void)addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    
    if (range.location !=NSNotFound) {
        NSMutableAttributedString *mutableAttribString = [self.mainTextLabel.attributedText mutableCopy];
        [mutableAttribString addAttributes:attributes range:range];
        self.mainTextLabel.attributedText = mutableAttribString;
    }

    
}
-(NSArray *)wordList
{
    NSArray *wordList = [[self.mainTextLabel.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([wordList count]) {
        return wordList;
    }else{
        return @[@""];
    }
}
- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList] count]-1;
    self.selectedWordLabel.text = [self selectedWord];
}

-(NSString *)selectedWord
{
    return [self wordList][(int)self.selectedWordStepper.value];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSelectedWord];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
