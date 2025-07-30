#  1.NSObject isa指针 8字节64位

struct NSobject_IMPL {
 Class isa
}

 typedef struct objc_class *Class;
 
# 2.那么类对象
 struct objc_class : objc_object {
     // Class ISA;
     Class superclass; 父类
     cache_t cache;             方法缓存
     class_data_bits_t bits;    用于获取类的信息  存储的是  class_rw_t 类型数据

     // 省略其他方法
     。。。
 }
struct class_rw_t {
    // Be warned that Symbolication knows the layout of this structure.
    uint32_t flags;
    uint16_t witness;

    explicit_atomic<uintptr_t> ro_or_rw_ext;

    Class firstSubclass;
    Class nextSiblingClass;

private:
    using ro_or_rw_ext_t = objc::PointerUnion<const class_ro_t, class_rw_ext_t, PTRAUTH_STR("class_ro_t"), PTRAUTH_STR("class_rw_ext_t")>;
    class_rw_ext_t *extAlloc(const class_ro_t *ro, bool deep = false);
}
struct class_rw_ext_t {
    DECLARE_AUTHED_PTR_TEMPLATE(class_ro_t)
    class_ro_t_authed_ptr<const class_ro_t> ro;
    method_array_t methods;  // 方法
    property_array_t properties; // 属性
    protocol_array_t protocols; // 协议
    const char *demangledName;
    uint32_t version;
};
struct class_ro_t {
    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;
    const ivar_list_t * ivars; //成员变量
    objc::PointerUnion<method_list_t, relative_list_list_t<method_list_t>, method_list_t::Ptrauth, method_list_t::Ptrauth> baseMethods;
    objc::PointerUnion<protocol_list_t, relative_list_list_t<protocol_list_t>, PtrauthRaw, PtrauthRaw> baseProtocols;
}





#  3.union 共用体 一个联合变量的长度等于各成员中最长的长度 。一个联合体类型必须经过定义之后, 才能使用它，才能把一个变量声明定义为该联合体类型。

 objc_object 的  isa指针是isa_t类型的指针. isa 共用体 
struct objc_object {
     private:
         isa_t isa;
    public:

        // ISA() assumes this is NOT a tagged pointer object
        Class ISA(bool authenticated = false) const;

        // rawISA() assumes this is NOT a tagged pointer object or a non pointer ISA
        Class rawISA() const;

        // getIsa() allows this to be a tagged pointer object
        Class getIsa() const;
        
        uintptr_t isaBits() const;
 .....此处省略很多行
 }
 
 union isa_t
 {
     isa_t() { }
     isa_t(uintptr_t value) : bits(value) { }

     Class cls;         // 表明所属的类 cls是指针，占8字节  对象的isa里面关联了类的信息，并且该类是通过isa的bits与ISA_MASK做按位与运算得来的
     uintptr_t bits;    // bits是long类型，占8字节


 ###   define ISA_MASK        0x0000000ffffffff8ULL
 ###   define ISA_MAGIC_MASK  0x000003f000000001ULL
 ###   define ISA_MAGIC_VALUE 0x000001a000000001ULL
     struct {
         uintptr_t nonpointer        : 1;
         uintptr_t has_assoc         : 1;
         uintptr_t has_cxx_dtor      : 1;
         uintptr_t shiftcls          : 33; // MACH_VM_MAX_ADDRESS 0x1000000000 因为shiftcls记录的类的相关信息
         uintptr_t magic             : 6;
         uintptr_t weakly_referenced : 1;
         uintptr_t deallocating      : 1;
         uintptr_t has_sidetable_rc  : 1;
         uintptr_t extra_rc          : 19;
 ###       define RC_ONE   (1ULL<<45)
 ###       define RC_HALF  (1ULL<<18)
     };
 };
 
 # 4.创建出来的对象只包含成员变量的大小 方法是存在类对象里面的
 

# 5.静态去除无用的类
# 6.怎么判断一个OC类有没有被初始化过 https://blog.harrisonxi.com/2021/02/%E6%80%8E%E4%B9%88%E5%88%A4%E6%96%AD%E4%B8%80%E4%B8%AAOC%E7%B1%BB%E6%9C%89%E6%B2%A1%E6%9C%89%E8%A2%AB%E5%88%9D%E5%A7%8B%E5%8C%96%E8%BF%87.html

大概思路 就是 先获取到所有的类 objc_copyClassList
然后获取到主bundle下面的类 【去除系统类】 class_getImageName  获取类的路径
然后 记录某个类是否被用过 根据类对象里面的 isInitialized  根据 内存偏移地址 获取到值
ObjC的类第一次被使用时会调用+initialize方法，类被加载过后cls->isInitialized会返回True。isInitialized方法读取了metaClass的data变量里的flags，如果flags里的第29位为1，则返回True。

包大小瘦身可以从纯技术视角瘦身，也可以从逻辑视角瘦身。

从纯技术视角有两种思路，第一种思路是优化编译逻辑， 第二种思路是删减各种其他类型（非编译产物）的文件。编译优化对业务逻辑无侵入式，风险和成本比较低，但收益通常也不高。删减文件则比较复杂，删减资源文件收益高但成本不小，逐个删减源码文件风险高且收益小。

相比而言，从逻辑的视角瘦身效果会更明显。站在逻辑的视角，工程是由许多功能模块组成的，主要可以分为业务功能模块（首页、搜索、收银台、订单）、基础功能模块（网络库、图片库、中间件、各种三方库...）。大型工程通常几百甚至上千个模块组成，小模块的有几十KB，大的模块有1MB~10+MB。功能模块内聚性强，当某个功能模块可以废弃或被替代时，整体下线的风险和成本比较低，ROI很高。
https://developer.aliyun.com/article/981881


## 结构体内存对齐 - 结构体的整体对齐值为其成员中最大自然对齐值的整数倍
## 操作系统内存对齐 - 操作系统会给16/其他的倍数的桶内存


# 7.如何获取对象的内存大小
sizeOf 编译的时候就确定的多大  Person *p = [[Person alloc]init]; sizeOf(p) p z指针的大小
class_getInstanceSize计算的是传入的参数（对象）所有属性（对象内部）大小相加之后内存对齐的大小（不要忘记isa;8字节对齐）
mallocSize 获取真实内存的大小

# 8.OC对象的分类
instance对象 实例对象。存储的是成员变量的值 isa。本身就是isa 的地址   isa 指向的是类对象
class对象 【class 方法 获取到的都是类对象】 里面也有一个isa。参考2。属性信息 对象方法 协议信息 成员变量信息
meta-class对象 类方法

【object_getClass(class)】 传入实例对象 获取到的就是 类对象   传入类对象-获取到的就是原类对象

Class class1 = objc_getClass(per1);    传入字符串
Class class2 = object_getClass(per1);  [return isa] 传入实例对象 获取到的就是 类对象   传入类对象-获取到的就是原类对象 如果是meta_class 那么返回NSObject

superclass 找到父类的方法
原类对象的meta_class  superclass 找到类方法
之前对象的isa存的就是类对象的isa地址 之后 需要进行一次位运算


#  iOS 方法调用的流程
先根据isa找到类对象的方法缓存里面找
到方法列表查找 
到父类的方法缓存里面找
到父类的方法列表找
一直找到NSObject 找不到之后走方法解析


# isMemberOfClass isKindOfClass
isMemberOfClass - 方法是传入和类对象 和 自己的类对象比较
isMemberOfClass + 方法是传入和元类对象 和 自己的元类对象比较

# 关联对象原理
总的来说，关联对象主要就是两层哈希map的处理，即存取时都是两层处理，类似于二维数组
AssociationsHashMap是以DisguisedPtr<objc_object>为key，ObjectAssociationMap为Value的HashMap。
其中DisguisedPtr为范型，包装了关联的对象self。
第一层是对象的地址包装的key。 对象地址： BucketT
第二层是我们传入的key
dealloc

