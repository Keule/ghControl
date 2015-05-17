#import "CHLConstants.h"

#define DEBUG_MODE YES

#define API_KEY_CRASHLYTICS_FM @"084682738864da1ec6a813e26c5ebe9059769dd0"
#define API_KEY_CRASHLYTICS API_KEY_CRASHLYTICS_FM
#define API_KEY_HOCKEYAPP @""
#define API_KEY_LOCALYTICS @""


typedef NS_ENUM(NSUInteger, FMBezierSingleAnimationViewState) {
    FMBezierSingleAnimationViewStateClean = 1,
    FMBezierSingleAnimationViewStateStandard = 2,
    FMBezierSingleAnimationViewStateSelected = 3,
    FMBezierSingleAnimationViewStateOutro
};


#define FM_IS_IPHONE_4    ([[UIScreen mainScreen] bounds].size.height == 480)
#define FM_IS_IPHONE_5    ([[UIScreen mainScreen] bounds].size.height == 568)
#define FM_IS_IPHONE_6    ([[UIScreen mainScreen] bounds].size.height == 667)
#define FM_IS_IPHONE_6_PLUS    ([[UIScreen mainScreen] bounds].size.height == 736)

#define FM_IS_IPAD        UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define PROPERTY_AS_STRING(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

#define INPUT_REQUIRED_MARK @"*"

#define LINT_SUPPRESS_UNUSED_ATTRIBUTE __attribute__((annotate("oclint:suppress")))

#define LINT_SUPPRESS_CYCLOMATIC_COMPLEXITY __attribute__((annotate("oclint:suppress[high cyclomatic complexity]")))

#define LINT_SUPPRESS_NON_COMMENTED_LINES  __attribute__((annotate("oclint:suppress[high ncss method]")))