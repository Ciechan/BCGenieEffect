BCGenieEffect
==========

OSX style genie effect inside your iOS app.

## Features

- UIView category
- Custom destination/start rectangle and its edge
- CoreAnimation based

## How To Use

### Genie in


```
CGRect endRect = CGRectMake(30, 40, 50, 60);
[view genieInTransitionWithDuration:0.7 
                    destinationRect:endRect 
                    destinationEdge:BCRectEdgeTop 
                         completion:^{
                          	NSLog(@"I'm done!");
                          }];
```

[![](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/genieIn.gif)](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/genieIn.gif)

### Genie out


``` 
CGRect startRect = CGRectMake(30, 40, 50, 60);
[view genieOutTransitionWithDuration:0.7 
                           startRect:startRect
                           startEdge:BCRectEdgeLeft 
                          completion:nil];
```

[![](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/genieOut.gif)](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/genieOut.gif)

### Parameters

Both `endRect` and `startRect` should be specified in coordinates of view's superview.

The `edge` parameter is one of the four rect's edges:

- `BCRectEdgeTop`
- `BCRectEdgeLeft`
- `BCRectEdgeBottom`
- `BCRectEdgeRight`

### Positioning limitations

Due the way BCGenieEffect works there are some limitations in spacing between animated view and destination rect. For the following examples we will assume that the destination edge is `BCRectEdgeTop`.

#### Correct positioning

Let's start with situations in which animation will work. As you can see there is a clear and logical path which animated view will follow, it slips into the destination rect easily.

[![](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/positioningCorrect.png)](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/positioningCorrect.png)

#### Unadvisable positioning

While this example might seem similar, you should notice that the bottom edge of animated view is *below* the top edge of destination rect. While on OSX the window will move up so that its bottom edge is above the dock, I've decided not to implement this autocorrection. BCGenieEffect will still perform the animation, however the results might be glitchy. It is advised that you either decide that the glitch is not important or manually move/animate the view to evade the problem. 
When unadvisable positioning occurs, BCGenieEffect will `NSLog` a warning into console:

```
Genie Effect Warning: The bottom edge of animated view overlaps top edge of destination rect. Glitches may occur.
```

[![](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/positioningUnadvisable.png)](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/positioningUnadvisable.png)
#### Incorrect positioning

The picture presents situation in which BCGenieEffect will not fire at all, since the requested animation curve is irrational. Positioning the view correctly will remove the problem.

As before, BCGenieEffect will notify you of a problem by spilling `NSLog` into console:

```
Genie Effect ERROR: The distance between top edge of animated view and top edge of destination rect is incorrect. Animation will not be performed!
```
[![](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/positioningIncorrect.png)](https://raw.github.com/Ciechan/BCGenieEffect/master/Screens/positioningIncorrect.png)

## Requirements

- iOS 5.0
- ARC
- QuartzCore framework in your project



## Contact

Bartosz Ciechanowski

[@BCiechanowski](https://twitter.com/BCiechanowski)

## License

BCGenieEffect is released under an MIT license.

Copyright (c) 2012 Bartosz Ciechanowski

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

