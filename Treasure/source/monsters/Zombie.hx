package monsters;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSpriteUtil;

class Zombie extends Monster {
	override public function new(xPos:Int, yPos:Int, Player:player.Player) {
		super(xPos, yPos);

		loadGraphic("assets/images/zombie.png", true, 8, 8);

		_player = Player;

        _speed = 8;
        _turn = false;
        _isMoving = false;
        _distance = 0;
		// playerPos = FlxPoint.get();

		// width = 38;
		// height = 42;
		// offset.x = 30;
		// offset.y = 48;

		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("idle", [0, 1], 20, true);
        animation.add("death", [0, 1], 20, false);
	}

    override public function update(elapsed:Float):Void {
        if (_turn) {
            var diff_x = _player.x - x;
            var diff_y = _player.y - y;
            if (diff_x > 0)
                _dir = RIGHT
            else if (diff_x < 0)
                _dir = LEFT
            else if (diff_y > 0)
                _dir = TOP
            else if (diff_y < 0)
                _dir = DOWN
            _turn = false;
        }
        if (_distance >= TILE_WIDTH) {
            _distance = 0;
            velocity.x = velocity.y = 0;
            _isMoving = false;
        }
        if (_isMoving) {
            switch (_dir) {
                case TOP: velocity.y += speed;
                case DOWN: velocity.y -= speed;
                case LEFT: velocity.x -= speed;
                case RIGHT: velocity.x += speed;
            }
        }

        super.update(elapsed);
    }

    override public function draw():Void {

        animation.play("idle");
        if (velocity.x > 0)
            facing = FlxObject.LEFT;
        else
            facing = FlxObject.RIGHT;  

        super.draw();
	}

	override public function kill():Void {
		if (!alive)
			return;

		// FlxG.sound.play(FlxAssets.getSound("assets/sounds/asplode"));
        animation.play("death");
		super.kill();

		FlxSpriteUtil.flicker(this, 0, 0.02, true);
	}
}