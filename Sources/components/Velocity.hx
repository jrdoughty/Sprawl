package components;

@:forward
abstract Velocity(Vec2) {

    public inline function new(x = .0, y = .0) this = new Vec2(x, y);

}
