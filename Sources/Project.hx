package;

import systems.Animation;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import echoes.Workflow;
import components.AnimComp.AnimData;
import haxe.ds.StringMap;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import kha.Color;
import kha.FastFloat;

class Project {
	var characterEcho:Entity;
	public var numEnemys:Int = 100;
	public var score:Int = 0;
	public var fps:Int = 0;
	public var enemys:Array<Enemy> = [];
	public var enemiesEcho:Array<Entity> = [];

	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		Scheduler.addTimeTask(secondTick, 0, 1);
		var images = Assets.images;
		characterEcho = new Entity().add(
			new Position(Main.WIDTH /2 , Main.HEIGHT-Main.HEIGHT/5),
			new Velocity(0,0),
			new components.Player(),
			new ImageComp(images.main)
		);
		var i;
		for(i in 0...numEnemys)
		{
			var speed = (Math.random()+.5)*40;
			var scale = Math.random()*3;
			enemiesEcho.push(new Entity().add(
				new Position(Main.WIDTH * Math.random(), 0),
				new Velocity(0,(Math.random()+.5)*40),
				new components.Enemy(),
				new Scale(scale,scale),
				new ImageComp(images.alt),
				AnimComp.createAnimDataRange(0,3,Math.round(speed)),
				new WH(32,32),
				new AnimData(new StringMap()),
				new Visible(true),
				new Angle(360 * Math.random())
			));
		}
	}

	function update(): Void 
	{
		Workflow.update(60 / 1000);
	}

	function secondTick(): Void 
	{
		fps = score;
		score = 0;
	}
	function render(framebuffer: Framebuffer): Void 
	{
		var graphics = framebuffer.g2;
		graphics.begin();
		//Scene.the.render(graphics);Assets.images.back
		
		graphics.drawScaledImage(Assets.images.back,0,0,Main.WIDTH,Main.HEIGHT);
		for(i in enemiesEcho)
		{
			//Animation.render(graphics,i.get(AnimComp),i.get(ImageComp),i.get(WH),i.get(Position),i.get(Scale));
			renderByEntity(graphics, i);
		}
		graphics.drawSubImage(characterEcho.get(ImageComp).value, characterEcho.get(Position).x, characterEcho.get(Position).y, 0, 0, 32, 32);
		//graphics.drawRect()
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 48;
		graphics.drawString(fps+"", 540, 32);
		graphics.end();	
		
		score++;
	}
	
    public static function renderByEntity(g: Graphics, e:echoes.Entity): Void {
		var ic = e.get(ImageComp);
		var ac = e.get(AnimComp);
		var wh:WH = e.get(WH);
		var pos:Position = e.get(Position);
		var s:Scale = e.get(Scale);
		var vis:Visible = e.get(Visible);
		var angle:Angle = e.get(Angle);
		if (ic.value != null && vis != null && cast(vis, Bool) )
			{
			g.color = Color.White;
			if (angle != null && cast(angle,FastFloat) != 0) 
					g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(pos.x , pos.y )).multmat(FastMatrix3.rotation(cast(angle,FastFloat))).multmat(FastMatrix3.translation(-pos.x , -pos.y )));
			g.drawScaledSubImage(ic.value, Std.int(ac.indices[ac.index] * wh.w) % ic.value.width, 
            Math.floor(ac.indices[ac.index] * wh.w / ic.value.width) * wh.h, 
            wh.w, wh.h, 
            Math.round(pos.x), Math.round(pos.y), 
            wh.w * s.x, wh.h * s.y);
			if (angle != null && cast(angle,FastFloat) != 0) 
				g.popTransformation();
        }
		#if debug_collisions
			g.color = Color.fromBytes(255, 0, 0);
			g.drawRect(x - collider.x * scaleX, y - collider.y * scaleY, width, height);
			g.color = Color.fromBytes(0, 255, 0);
			g.drawRect(tempcollider.x, tempcollider.y, tempcollider.width, tempcollider.height);
		#end
	}
	
	
}
