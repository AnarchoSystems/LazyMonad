# LazyMonad


# Installation
Clone the project, create a folder at /Library/Developer/XCode/Templates/YourTemplateName.xctemplate and copy the content of this project to this folder.


# sage
In XCode, create a new File and choose YourTemplateName from the list of templates in the wizzard. Enter a name for the file you want to create and confirm. The file you create contains a generic type named YourTemplateName with a default implementation.


You can change this generic type in whichever way you like. If you change the implementation of the ```pure``` function, make sure that the type signature remains unchanged.


The code below YourTemplateName is written in such a way that you should rarely need to touch it (except maybe in a name refactor or when you add additional generic type arguments). It provides YourTemplateName with a simple nested type called ```Coyoneda```.

Here's the catch: ```Coyoneda``` allows you to chain functorial and monadic arrows on YourTemplateName *before* you even provide an implementation for the functor/monad operations. These can be dynamically handed to ```Coyoneda``` using ```runUnsafe``` - this is the point where you actually need some type conforming to YourTemplateNameMonadImplementation.
