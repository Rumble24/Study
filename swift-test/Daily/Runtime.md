#  方法交换

// 方法交换需要注意的事项
// 1.首先需要判断需要交换的方法是否存在 避免循环调用
// 2.避免多次调用 导致交换无效
// 3.最好交换自己的方法 要是交换父类的方法 那么需要添加父类方法 实现
// 4.需要判断是否有原来的方法 没有的话需要增加一个空实现 避免崩溃
 + (void)lg_bestMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL{

    if (!cls) NSLog(@"传入的交换类不能为空");
    
    // 获取类中的方法
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    // 要被交换的方法
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    
    // 判断类中是否存在该方法-避免动作没有意义
    if (!oriMethod) { 

        // 在oriMethod为nil时，添加oriSEL的方法，实现为swiMethod
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));

        // 替换后将swizzledSEL复制一个不做任何事的空实现,代码如下:
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){

            NSLog(@"来了一个空的 imp");
        }));
    }

    // 一般交换方法: 交换自己有的方法 -- 走下面 因为自己有意味添加方法失败
    // 交换自己没有实现的方法:
    //   首先第一步:会先尝试给自己添加要交换的方法 :personInstanceMethod (SEL) -> swiMethod(IMP)
    //   然后再将父类的IMP给swizzle  personInstanceMethod(imp) -> swizzledSEL
    //oriSEL:personInstanceMethod

    // 向类中添加oriSEL方法，方法实现为swiMethod
    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    
    // 自己有意味添加方法失败-所以这里会是false
    if (didAddMethod) {
        // 如果添加成功，表示原本没有oriMethod方法，此时将swizzledSEL的方法实现，替换成oriMethod实现
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        // 方法交换
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}
