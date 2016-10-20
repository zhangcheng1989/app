
#define ZCSingletonH(name) + (instancetype)shared##name;
#define ZCSingletonM(name)\
static id _instance;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _instace = [super allocWithZone:zone];\
});\
    return _instance;\
}\
\
+ (instancetype)shared##name{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instace = [[self alloc]init];\
    });\
    return _instance;\
}\
\
- (id)copyWithZone:(NSZone *)zone{\
    return _instance;\
}
