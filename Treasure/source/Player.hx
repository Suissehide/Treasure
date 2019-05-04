package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup.FlxTypedGroup;

class Player extends FlxSprite {
	public var cooldown:Bool = true;

    var LENGTH_TILE:Float = 16;
    var SPEED:Float = 0.5;
    public var cooldown_anim:Bool = false;
    var direction_move:Int = 0;
    var number_anim:Float = 0;

	public function new(X:Float, Y:Float) {
		super(X, Y);

        loadGraphic("assets/images/Itch release tileset example sprites 01 2x.png");
        setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		// set direct a true ou set a true quand on lance la partie        cooldown = false;
	}

	override public function update(elapsed:Float):Void {
		if (cooldown == true) {
			// movement allowed
			if (FlxG.mouse.pressed || FlxG.keys.anyPressed([UP, LEFT, DOWN, RIGHT, Z, Q, S, D])) {
				if ((FlxG.mouse.x > (x + LENGTH_TILE) && FlxG.mouse.x < (x + 2 * LENGTH_TILE)) || FlxG.keys.anyPressed([RIGHT, D])) {
					// go right
                    facing = FlxObject.LEFT;
					cooldown_anim = true;
                    direction_move = 0;
					cooldown = false;
				} else if ((FlxG.mouse.x < x && FlxG.mouse.x > (x - LENGTH_TILE)) || FlxG.keys.anyPressed([LEFT, Q])) {
					// go left
                    facing = FlxObject.RIGHT;
					cooldown_anim = true;
                    direction_move = 1;
					cooldown = false;
				} else if ((FlxG.mouse.y > (y + LENGTH_TILE) && FlxG.mouse.y < (y + 2 * LENGTH_TILE)) || FlxG.keys.anyPressed([DOWN, S])) {
					// go down
					cooldown_anim = true;
                    direction_move = 2;
					cooldown = false;
				} else if ((FlxG.mouse.y < y && FlxG.mouse.y > (y - LENGTH_TILE)) || FlxG.keys.anyPressed([UP, Z])) {
					// go up
					cooldown_anim = true;
                    direction_move = 3;
					cooldown = false;
				}
			}
		}
        if (number_anim >= LENGTH_TILE) {
            number_anim = 0;
            cooldown_anim = false;
        }
        if (cooldown_anim == true) {
            number_anim = number_anim + 1;
            switch direction_move {
                case 0 : x = x + SPEED;
                case 1 : x = x - SPEED;
                case 2 : y = y + SPEED;
                case 3 : y = y - SPEED;
            }
        }
        
		super.update(elapsed);
	}

    override public function kill():Void {
        if (!alive)
            return;
		FlxSpriteUtil.flicker(this, 1, 0.04, true);
		super.kill();
	}
}