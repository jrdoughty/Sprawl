package components.core;

class Bounds2D implements hxbit.Serializable
{
    public var w:Float;
    public var h:Float;
    public function new(w = .0, h = .0)
    {
        this.w = w;
        this.h = h;
    }
}