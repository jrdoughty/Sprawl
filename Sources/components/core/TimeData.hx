package components.core;

import components.core.TimeData;
import haxe.Timer;
import haxe.ds.StringMap;

@:forward
abstract TimeData(StringMap<TimeComp>)
{
	inline public function new(sm:StringMap<TimeComp>) {
		this = sm;
	  }
}