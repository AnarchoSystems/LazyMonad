# LazyMonad


# Installation

Clone the project, create a folder at /Library/Developer/XCode/Templates/ (or navigate there if you already have templates) and copy the xctemplate folders from this project to this folder. Restart XCode if it is running.


# Usage

## Coyoneda

In XCode, create a new File and choose Coyoneda from the list of templates in the wizzard. Enter a name for the Domain Specific Language (DSL) you want to create and confirm. You will get two files, YourDSLName.swift, YourDSLNameCoyoneda.swift, and if you enabled the option "also generate Free", you additionally get YourDSLNameFree.swift.


You can change the data structure YourDSLName in whichever way you like. Renaming refactors and complete replacements of the implementation should work out of the box (even though you may want to rename the protocol YourDSLNameFunctorImplementation and YourDSLNameInterpreter). If you change the names or the number of generic arguments, you will need to do a few manual changes in YourDSLNameCoyoneda.swift and YourDSLNameFree.swift. Thanks to type nesting and type aliases, this type of refactor shouldn't be too complicated either.

```Coyoneda``` is essentially a wrapper that enables you to map over your generic DSL type without being forced to specify an implementation. You only need to specify the implementation of map, when you want to get back a mapped value of your DSL type via ```runUnsafe```.

```Free``` can be thought of as the fixpoint of a generic type. If you nest your generic type into its own generic argument, you get a new type. This may be a problem if your methods for your generic type depend on the underlying type. This is where ```Free``` comes into play: it is essentially a list of nested copies of your generic type.

If you have such a stack of nested types of unknown length, the natural question comes up: how do we unwind this? For this, there's a protocol named YourDSLNameInterpreter. Its single method, ```interpret```, describes exactly what it means to pop a single element from the stack.

Another way to think of this is to view your ```Free``` stack of nested generic value as instructions in a program. To pop one instruction from the stack then gets the meaning of carrying out one instruction. Hence the name "interpreter".

## Free

This template generates a ```Free``` monad for your DSL using yet another technique. In the Coyoneda template, the ```Free``` monad requires your DSL to be a functor, which we conveniently bypass using ```Coyoneda```. In this template, there is no such requirement and you don't need to specify a functor implementation when calling ```runUnsafe```.

The ```Free``` monad in this template is based on continuations. While computations on "pure" values will just be carried out, computations on "impure" values are kept in suspension by storing the impure value and an impure continuation. Both the impure value and the continuation are then handed to an interpreter.

The fact that your DSL doesn't need to be a functor is an obvious advantage. A mild drawback is that interpreters need to be somewhat more powerful: while in the Coyoneda template they only need to know how to flatten a stack of your generic DSL type, in this template you actually need to compute some pure value from something impure.

However, free monads (in both templates) have the amazing property that they can be interpreted into any other monad. If your DSL consists only of the following phantom type:

```
struct Nil<T>{}
```

and your Interpreter knows how to convert a ```Nil<T>``` into an ```Array<T>``` (which is trivial in this instance), you can parse your entire workflow into an ```Array<T>``` rather than a ```T```! Moreover, in this template, you don't even have to call the continuation on ```[]``` because a monadic workflow on ```[]``` (only ```map``` and ```flatMap```) will result in a ```[]```.

Finally, it should be noted that the ```Free``` monad implementation in this template doesn't even require that the genenric types targeted by interpreters are in fact monads. It suffices that you can lift a pure value into the target context. Unless you want to do further computations in the target monad, you can delete the ```map``` and ```flatMap``` methods.

To highlight these cool features, this template includes interpreter protocols to pure values and to two generic types, one for tests and debugging and one for production. If Swift had higher kind types, the latter two (and their respective ```runUnsafe``` methods on ```Free```) could be unified into a single protocol.

# See also
https://www.haskellforall.com/2012/06/you-could-have-invented-free-monads.html
https://underscore.io/blog/posts/2015/04/14/free-monads-are-simple.html
https://medium.com/@olxc/free-monads-explained-pt-1-a5c45fbdac30
https://medium.com/@olxc/yoneda-and-coyoneda-trick-f5a0321aeba4
