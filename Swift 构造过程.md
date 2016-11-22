# Swift 构造过程

#### step 1.

首先从Objective-C的构造开始说起

```objective-c
#import <Foundation/Foundation.h>
@interface Object : NSObject
@end
  
#import "Object.h"
@implementation Object
- (instancetype)init {
  if (self = [super init]) {
  }
  return self;
}
@end
```

在Objective-C的构造函数init中首先调用init，沿着继承链一直往上走，知道到底继承链的顶端，继而进行初始化继承链逐个返回，如果继承链中各类初始化没错才能继续进行 Object的初始化

而Swift版本如下

```swift
import UIKit
class CustomObj: NSObject {  
    override init() {
		// super.init() 隐式被调用
    }
}
```

关于override，super.init() 隐式被调用稍后作分析。对比发现Swift中添加了**override**

其他的跟OC好像没有不同。

#### step2.

往类中添加属性

```objective-c
#import <Foundation/Foundation.h>
@interface Object : NSObject
@property (nonatomic, strong) NSString *property;
@end
  
#import "Object.h"
@implementation Object
- (instancetype)init {
  if (self = [super init]) {
    self.property = @"";	// Situation 1. 初始化property
    // self.property = @"";  Situation 2. 不初始化 property 
  }
  return self;
}
@end
```

你会发现 初始化property和不初始化property 在OC中均不会报错，这是因为OC中***向 nil发送消息不会报错***

```swift
import UIKit

class Object: NSObject {
    let property: String   
    override init() {
        property = ""	// 注释掉会报错
        // property = "" Property 'self.property' not initialized at implicitly generated super.init call
    }
}
```

`Property 'self.property' not initialized at implicitly generated super.init call` self.property 在super.init 调用之前完成初始化，我们没有调用super.init,但是错误中明确指出在super.init调用的时候self.property 没有初始化，这就是之前说的 `隐式调用super.init` 隐式调用 `super.init` 有一个非常重要的条件就是这个构造方法时 **指定初始**方法，只有在指定初始化方法中才可以按着继承链往上调用父类初始化，什么是**指定初始化** ？？

如果我想重新父类的属性该怎么办？？这里引用 The Swift Programming Language 中的例子

```swift
class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}

class Bicycle: Vehicle {
  var brand: String
  override init() {
  	brand = "Brank"		// 1.
    super.init()
    numberOfWheels = 2
  }
}
```

这就是遵循Swift 4个安全检查，确保不会出现错误，具体的安全检查如下（目前只用到两个）：

1. 指定构造器必须保证它所在类引入的所有属性都必须初始化完成，之后才能将其他构造任务向上代理给父类的构造器

   上面的Bicycle类就是先将自己类的brand属性进行初始化，之后再调用super.init向上代理父类的构造器

2. 指定构造器必须先向上代理调用父类的构造器，然后再为任意属性赋新值，如果调用顺序不是这样，那么指定构造器赋值的新值将会被父类构造器所覆盖

#### step4.

我们将上面的例子进行改造

```swift
class Vehicle {
    var numberOfWheels = 0
    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }
}

class Bicycle: Vehicle {
    var brand: String
    init(brand: String) {
        self.brand = brand
        // Error: Super.init isn't called on all paths before returning from initializer
    }
}
```

从上面例子可以看到产生Error，那么我们尝试解决：error是说父类构造器在返回实例之前没有被调用。唉我们之前不是说过有隐式调用吗？？那我们尝试主动调用试试，代码修改如下：

```swift
class Vehicle {
    var numberOfWheels = 0
    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }
}

class Bicycle: Vehicle {
    var brand: String
    init(brand: String) {
        self.brand = brand
        super.init()// Error: Missing argument for parameter 'numberOfWheels' in call
    }
}
```

有报错，缺失参数numberOfWheels，，观看我们Vehicle定义，定义指定构造函数init(numberOfWheels: Int), 根据苹果的说法，子类调用父类只能调用指定构造函数，即子类Bicycle只能调用init(numberOfWheels:), 那我们改之试试

```swift
class Vehicle {
    var numberOfWheels = 0
    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }
}

class Bicycle: Vehicle {
    var brand: String
    init(brand: String) {
        self.brand = brand
        super.init(numberOfWheels: 2)
    }
}
```

OK, 没有Error

现在回到step4第一段代码，为什么没有super.init调用, 这里引入一个概念**默认构造器**，如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器(default initializers)。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。

第一个代码中numberOfWheels有默认值，所以Swift会创建一个默认初始化init，但是再看默认初始化化条件，是类没有提供自定义构造器，我们提供了，OK，那我们去掉再试试：

```swift
class Vehicle {
    var numberOfWheels = 0
}

class Bicycle: Vehicle {
    var brand: String
    init(brand: String) {
        self.brand = brand
    }
}
```

OK, 没有问题

#### step5.

```swift
class Vehicle {
    var numberOfWheels = 0
    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }
}

class Bicycle: Vehicle {
    var brand: String
    init(brand: String) {
        self.brand = brand
        super.init(numberOfWheels: 2)
    }
    
    override init(numberOfWheels: Int) {
        self.brand = ""
        super.init(numberOfWheels: numberOfWheels)
    }
}
```

**重写指定构造器需要加`override`**

`override`子类提供一个跟父类相同的构造器，实际上是在重写父类这个构造器，因此必须带上`override`关键字，即使重写父类自动提供的默认构造器，也同样需要加上`override`关键字

`override`关键字会去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否正确

> 注意
>
> 当你重写一个父类的指定构造器时，你总是需要写 override 修饰符，即使你的子类将父类的指定构造器重写为了便利构造器。	

**重写便利构造器不需要加`override`**

说了这么多，那什么是**指定构造器**什么是**便利构造器**呢？？

在上面我们所写的所有代码中的init都是指定构造器，指定构造器的写法如下：

```swift
init(params) {}
```

>指定构造器是类中最主要的构造器，一个指定构造器将初始类中所提供的所有属性，并根据继承链调用父类的初始化来实现父类的初始化

**便利构造器**

```swift
convenience init(params){}		
```

> 便利构造器是类中比较次要，辅助的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其提供参数

类的构造代理规则：

规则 1

`指定构造器必须调用其直接父类的的指定构造器。`

规则 2

`便利构造器必须调用同一类中定义的其它构造器。`

规则 3

`便利构造器必须最终导致一个指定构造器被调用。`

* 指定构造器必须总是向上代理
* 便利构造器必须总是横向代理


接下来通过实例来探讨下 **指定构造器** **便利构造器** ，实例来自于 苹果语法指南

```swift
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unname]")
    }
}
```

Foot类中包含一个name属性，一个指定初始化方法 (init(name:))一个便利构造器函数(convenience init()) ，便利构造器调用指定初始化方法，类中所有的存储属性只能在定义或者指定初始化方法中赋值，验证下：

```swift
class Food {
    var name: String
    var size: Double
    
    init(name: String) {
        self.name = name	// 1. Error: Return from initializer without initializing all stored properties
    }
    
    convenience init() {
        self.size = 10.0	// 2. Error: Use of 'self' in property access 'size' before self.init initializes self
        self.init(name: "[Unname]")
    }
}
```

第一个Error：从初始化方法返回并没有完成所有的存储属性初始化，这就是我们上面说的那个问题了；那第二个Error缘起何处？？

原因是在便利构造其中我们不负责类的创建工作，所以需要调用指定初始化方法来完成类的创建，但是上面的例子中我们是在调用初始化方法之前对size进行设置，此时对象并未创建完成，所以错，来，修改下：

```swift
class Food {
    var name: String
    var size: Double
    
    init(name: String) {
        self.name = name
        size = 0
    }
    
    convenience init() {
        self.init(name: "[Unname]")
        self.size = 10.0
    }
}
```

继续我们上面的讨论，接下来创建Food的子类：

```swift
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}	
```

首先我们来考虑下RecipeIngredient有几个可调用的初始化方法，它声明的两个肯定可以使用：

```swift
let r1 = RecipeIngredient(name: "", quantity: 1)
let r2 = RecipeIngredient(name: "")	
// 还有一个继承来的 init()
let r3 = RecipeIngredient()
```

在Food类中init() 内容调用 init(name:) 所以在子类中的构造函数调用顺序如下：

init() -> init(name:) ->init(name:, quantity:) -> super.init(name:)

这里有个注意点，就是我们在重写init(name:)时加`override` ,正如前面所说，当重写父类的指定初始化时需要加`override`关键字，即使在这里这个指定构造函数被重写为变量构造函数，同样到我们重写便利构造函数时变不需要添加`override`关键字

```swift
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    // 重写便利构造器
    convenience init() {
        self.init(name: "")
    }
}

```

你同样可以将父类的便利构造函数重写为指定构造函数

```swift
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    // 重写便利构造器为指定构造函数
    init() {
        quantity = 1
        super.init(name: "")
    }
}
```

> 还有一点需要注意：子类可以在初始化时改变继承来的变量属性值，但不可以改变继承来的常量属性值



关于 “构造器的自动继承”

子类在默认情况下不会继承父类的构造器，但如果满足特定的条件父类的构造器是可以被自动继承的。

前提**假设为子类中引入的所有新的属性都提供了默认值**以下两个规则适用：

1. 如果子类没有指定任何构造函数，它将自动继承所有父类的指定构造函数
2. 如果子类提供了所有父类**指定构造函数**，无论是通过1.继承来的还是提供了自定义实现它将自动继承父类所有的便利构造器。

上面Food那个例子也能看出这两条规则，我们重写了父类的指定的构造函数，那么我们同样继承了init个init(name:)两个便利构造函数

再添加一个类更深刻地了解下这两个规则：

```swift
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "?" : "?"
        return output
    }
}
```

>由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器ShoppingListItem 将自动继承所有父类中的指定构造器和便利构造器

#### step6

如果一个类，结构体，或者枚举类型的对象，在构造过程中可能失败，则为其定义一个可失败的构造器

> 可失败构造函数的参数名跟类型不能与其他*非可失败构造函数*的参数名，及其参数类型相同 

```swift
struct Animal {
    let speices: String
    init?(speices: String) {
        if speices.isEmpty {
            return nil
        }
        self.speices = speices
    }
}
```

可失败构造类型返回的类型为Optional类型

```swift
// 可以通过 guard来使用创建的Animal
guard let animal = Animal(speices: "Giraffe") {
    return
}

// 如果给 Animal传递一个空字符串，那么Animal创建失败，返回nil
```

我们通过一个例子来看下构造失败的传递

```swift
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}
```

上面就是可失败的构造函数的传递。就是子类调用父类

那么我想重写该怎么办，重写就有两种情况：

1. 父类是可失败构造函数，子类重写为非可失败构造函数
2. 父类是非可失败构造函数，子类重写为可失败构造函数

我们来挨个验证下：

```swift
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
    
    override init(name: String) {
        quantity = 1
        super.init(name: name)!
    }
}

```

OK, 没有问题

```swift
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    init() {
        name = ""
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
    
    override init(name: String) {
        quantity = 1
        super.init(name: name)!
    }
    
    override init?() { // Error: Failable initializer 'init()' cannot override a non-failable initializer
    }
}
```

出现问题Error：非可失败构造器不能被可失败构造器重写；



#### step7

**require** 构造函数，当一个类添加**require** 关键字时，子类都必须实现该构造器，在重写**require**构造函数时，不需要添加`override`

```swift
class SomeClass {
    required init() {
        // 构造器的实现代码 
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}
```

总结：

初始化注意好指定构造函数与便利构造函数区别就好，指定初始化中对类进行实例化，所以要在这里面进行属性赋值调用父类指定初始化方法的操作。而便利构造函数只是方便外部调用，并不赋值实例初始化，便利初始化要调用类的指定初始化来完成类的实例化，实例化后才可以修改类的属性