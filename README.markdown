Cardinal Spline:
===============

Purpose:
--------

To illustrate how to interpolate a [Catmull-Rom][wikipedia-cubic-hermite-spline] spline and how the spline is useful in game development.  It will also show how [Bezier splines][bezier-curve-wiki] are not cardinal, and do not pass through their control points.

Cardinal splines can be used for paths for AI or sprites to move along.

About:
------

After seeing how simple [cubic bezier spline][cocos2d-cubic-bezier-spline] interpolation was, I finally understood the math behind Catmull-Rom.

I found the [Catmull-Rom equation here][catmull-rom-equation]. 

[cocos2d-cubic-bezier-spline]: https://github.com/cocos2d/cocos2d-iphone/blob/develop/cocos2d/CCActionInterval.m#L803

[wikipedia-cubic-hermite-spline]: http://en.wikipedia.org/wiki/Cubic_Hermite_spline
[catmull-rom-equation]: http://www.mvps.org/directx/articles/catmull/
[bezier-curve-wiki]: http://en.wikipedia.org/wiki/Bézier_curve

Coming Soon:
------------

* Draw Bezier splines to show that they don't pass through their control points.
* Interpolate a series of points for both splines

