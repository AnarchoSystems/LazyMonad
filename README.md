# LazyMonad


# Installation
Clone the project, create a folder at /Library/Developer/XCode/Templates/YourTemplateName.xctemplate and copy the content of this project to this folder.


# Usage
In XCode, create a new File and choose YourTemplateName from the list of templates in the wizzard. Enter a name for the DSL you want to create and confirm. You will get two files, YourDSLName.swift, YourDSLNameCoyoneda.swift, and if you enabled the option "also generate Free", you additionally get YourDSLNameFree.swift.


You can change the data structure YourDSLName in whichever way you like. Renaming refactors and complete replacements of the implementation should work out of the box (even though you may want to rename the protocol YourDSLNameFunctorImplementation and YourDSLNameInterpreter). If you change the names or the number of generic arguments, you will need to do a few manual changes in YourDSLNameCoyoneda.swift and YourDSLNameFree.swift. Thanks to type nesting and type aliases, this type of refactor shouldn't be too complicated either.

```Coyoneda``` is essentially a wrapper that enables you to map over your generic DSL type without being forced to specify an implementation. You only need to specify the implementation of map, when you want to get back a mapped value of your DSL type via ```runUnsafe```.

```Free``` can be thought of as the fixpoint of a generic type. If you nest your generic type into its own generic argument, you get a new type. This may be a problem if your methods for your generic type depend on the underlying type. This is where ```Free``` comes into play: it is essentially a list of nested copies of your generic type.

If you have such a stack of nested types of unknown length, the natural question comes up: how do we unwind this? For this, there's a protocol named YourDSLNameInterpreter. Its single method, ```interpret```, describes exactly what it means to pop a single element from the stack.

Another way to think of this is to view your ```Free``` stack of nested generic value as instructions in a program. To pop one instruction from the stack then gets the meaning of carrying out one instruction. Hence the name "interpreter".

# See also
https://www.haskellforall.com/2012/06/you-could-have-invented-free-monads.html
https://underscore.io/blog/posts/2015/04/14/free-monads-are-simple.html
