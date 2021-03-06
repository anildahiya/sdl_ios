//
//  SDLTimer.h
//

#import <Foundation/Foundation.h>

@interface SDLTimer : NSObject

@property (nonatomic, copy) void (^elapsedBlock)(void);
@property (nonatomic, copy) void (^canceledBlock)(void);
@property (assign) float duration;

- (id)init;
- (id)initWithDuration:(float)duration;
- (void)start;
- (void)cancel;

@end
