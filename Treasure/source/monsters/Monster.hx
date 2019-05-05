package monsters;

import flixel.FlxSprite;
import flixel.tile.FlxTilemap;

class Monster extends FlxSprite {
	/**
	 * The player object
	 */
	var _player:Player;

    var _dir:Int;
    var _speed:Float;
    
    var _distance:Int;
    public var _cooldown:Bool = true;
	public var _isMoving:Bool = false;

    // public var playerPos(default, null):FlxPoint;

    public function init(X:Float, Y:Float)
	{
		reset(X, Y);
    }

    public function move(mWalls:FlxTilemap):Void {
        if (_cooldown) {
            var diff_x = _player.x - x;
            var diff_y = _player.y - y;
            if (diff_x > 0)
                _dir = 0;
            else if (diff_y > 0)
                _dir = 2;    
            else if (diff_x < 0)
                _dir = 1;
            else if (diff_y < 0)
                _dir = 3;
            _isMoving = true;
            _cooldown = false;
        }
    }
}

enum Direction {TOP; LEFT; DOWN; RIGHT;}