package monsters;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;

class Zombie extends Monster {
    static inline var TILE_WIDTH:Int = 16;
    var _invincible:Bool = true;

	override public function new(X:Int, Y:Int, Player:Player) {
		super(X, Y);

		loadGraphic("assets/images/zombie.png", true, 8, 8);

		_player = Player;

        _speed = 8;
        _turn = false;
        _isMoving = false;
        _distance = 0;
		// playerPos = FlxPoint.get();

		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("idle", [0], 10, true);
        animation.add("walk", [0, 1], 10, true);
        animation.add("death", [3], 1, false);
        animation.add("pop", [2], 20, true);
        animation.play("pop");
	}

    public function move(mWalls:FlxTilemap):Void {
        if (_turn) {
            var diff_x = _player.x - x;
            var diff_y = _player.y - y;
            if (diff_x > 0)
                _dir = 0;
            else if (diff_x < 0)
                _dir = 1;
            else if (diff_y > 0)
                _dir = 2;
            else if (diff_y < 0)
                _dir = 3;
            _isMoving = true;
            _turn = false;
        }
    }

    override public function update(elapsed:Float):Void {
        if (_distance >= TILE_WIDTH) {
            _distance = 0;
            _isMoving = false;
        }
        if (_isMoving) {
            _distance += 1;
            switch (_dir) {
                case 0 : setPosition(x + _speed, y);
                case 1 : setPosition(x - _speed, y);
                case 2 : setPosition(x, y + _speed);
                case 3 : setPosition(x, y - _speed);
            }
            animation.play("walk");
        } else
            animation.play("idle");
        super.update(elapsed);
    }

    override public function draw():Void {

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