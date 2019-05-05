package monsters;

import flixel.FlxSprite;

class Monster extends FlxSprite {
	/**
	 * The player object
	 */
	var _player:Player;

    var _dir:Int;
    var _speed:Float;
    
    var _distance:Int;
    public var _turn:Bool;
	var _isMoving:Bool;

    // public var playerPos(default, null):FlxPoint;

    public function init(X:Float, Y:Float)
	{
		reset(X, Y);
    }
}

enum Direction {TOP; LEFT; DOWN; RIGHT;}