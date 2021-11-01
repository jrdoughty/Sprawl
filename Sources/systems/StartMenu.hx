package systems;

import echoes.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import components.core.*;
import haxe.ds.StringMap;
import hxbit.Serializer;


class StartMenu extends System
{
    public function new() {
        var speed = 5;
        var images = Assets.images;
        
        new Entity().add(//Background
            new Position(0, 0),
            new ImageComp("menubackground"),
            new Scale(Main.WIDTH/images.menubackground.width,Main.HEIGHT/images.menubackground.height),
            new Bounds2D(images.menubackground.width,images.menubackground.height),
            new Visibility(),
            new RenderOffset2D(0.0, 0.0));
        new Entity().add(
            new Position(Main.WIDTH /2 , Main.HEIGHT/2),
            new ImageComp("button"),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new Bounds2D(48,16),
            new Visibility(),
            new ButtonComp('play'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2, Main.HEIGHT/2 + 96),
            new ImageComp("button"),
            new AnimData(new StringMap()),
            new Scale(10,5),
            new Bounds2D(48,16),
            new Visibility(.05,true),
            new ButtonComp('credits'),
            new GamePad(0),
            new KeyboardComp(),
            new MouseComp()
        );
        new Entity().add(
            new Position(Main.WIDTH /2-145, Main.HEIGHT/4),
            new Scale(10,30),
            new Visibility(),
            new TextComp("Git Gold","_8bitlim",kha.Color.Orange)
        );
        new Entity().add(
            new Position(Main.WIDTH /2-140, Main.HEIGHT/4),
            new Scale(10,28),
            new Visibility(),
            new TextComp("Git Gold","_8bitlim",kha.Color.Yellow)
        );
        if(Project.highScore>0)
        {
            new Entity().add(
                new Position(Main.WIDTH /2-145, Main.HEIGHT/4*3+27),
                new Scale(10,15),
                new Visibility(),
                new TextComp("High Score " + Project.highScore,"_8bitlim",kha.Color.Yellow)
            );
            new Entity().add(
                new Position(Main.WIDTH /2-145, Main.HEIGHT/4*3+127),
                new Scale(10,15),
                new Visibility(),
                new TextComp("Last Score " + Project.lastScore,"_8bitlim",kha.Color.Yellow)
            );
        }

        //var s = new Serializer();
        //var bits = s.
        
    }

    @u public function mouseBtnUpdate (m:MouseComp, b:ButtonComp, p:Position, wh:Bounds2D, s:Scale)
    {
        var mPos = new Position(m.x,m.y);
        if(m.mousePressed[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            trace(b.tag+' down');
        }
        else if(m.mouseUp[0] && Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            Project.activeState = b.tag;
        }
        else if(Utils.pointInAABBTestWithScaleCentered(mPos,p,wh,s))
        {
            //over            
        }
        else 
        {
            //out 
        }
    }


}