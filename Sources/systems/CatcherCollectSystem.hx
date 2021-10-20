package systems;

import echoes.Entity;
import nape.phys.BodyType;
import echoes.System;
import echoes.View;
import nape.shape.Circle;
import components.*;

class CatcherCollectSystem extends System {
    var circleView:View<Circle>;
    var scoreView:View<ScoreComp>;

    @u public function update(c:Catcher,p:Position,wh:WHComp) {
        for(i in circleView.entities)
        {
            if(i.get(Death) == null && Utils.CenteredRectCircleOverlapTest(p, wh, new Position(i.get(Circle).body.position.x,i.get(Circle).body.position.y),i.get(Circle).radius))
            {
                i.remove(Circle);
                i.add(new Death());
                scoreView.entities.head.value.get(ScoreComp).score += c.value;
                new Entity().add(
                    new AwardFont(c.value+""),
                    new Position(p.x,p.y-10)
                    );
            }    
        }
    }
}