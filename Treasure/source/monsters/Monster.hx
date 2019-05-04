package monsters;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;

class Monster extends FlxSprite {

    static inline var TILE_WIDTH:Int = 16;

	/**
	 * The player object
	 */
	var _player:Player;

    var _dir:Direction;
    var _speed:Float;
    
    var _distance:Int;
    var _turn:Bool;
	var _isMoving:Bool;

    // public var playerPos(default, null):FlxPoint;
}

enum Direction {TOP; LEFT; DOWN; RIGHT;}