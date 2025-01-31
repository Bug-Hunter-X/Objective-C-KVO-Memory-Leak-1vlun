The solution involves calling `removeObserver:` in the appropriate place, such as in `dealloc` or when the observed object is no longer needed.  Here's the corrected code:

```objectivec
@interface MyObject : NSObject
@property (nonatomic, strong) NSString *myString;
@end

@implementation MyObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // Handle changes
}
@end

@interface MyClass : NSObject
@property (nonatomic, strong) MyObject *myObject;
@end

@implementation MyClass
- (instancetype)init {
    self = [super init];
    if (self) {
        self.myObject = [[MyObject alloc] init];
        [self.myObject addObserver:self forKeyPath:@"myString" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
    [self.myObject removeObserver:self forKeyPath:@"myString"];
    [super dealloc];
}
@end
```
By adding `removeObserver:` in `dealloc`, the observer is correctly removed when `MyClass` is deallocated, preventing the memory leak.