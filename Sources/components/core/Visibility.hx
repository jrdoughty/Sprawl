package components.core;

import kha.FastFloat;

class Visibility
{
    @:s public var opacity:FastFloat = 1;//Not Yet Implemented
    @:s public var visible:Bool = true;

    public inline function new(opacity:FastFloat = 1,visible:Bool = true)
    {
        this.opacity = opacity;
        this.visible = visible;
    }
}
