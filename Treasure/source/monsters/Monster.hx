package monsters;

import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;

class Monster extends FlxSprite {
	/**
	 * The player object
	 */
	var _player:Player;

    var _dir:Int;
    var _speed:Float;
    
    var _distance:Int;
    var _spawning:Bool = true;
    public var _cooldown:Bool = false;
	public var _isMoving:Bool = false;

    // public var playerPos(default, null):FlxPoint;

    public function init(X:Float, Y:Float)
	{
		reset(X, Y);
        _spawning = true;
        _cooldown = false;
        _isMoving = false;
    }

    public function checkEntity(x, y, mWalls:FlxTilemap, monsters:FlxTypedGroup<monsters.Monster>):Bool
    {
        if (overlapsAt(x, y, mWalls))
            return (false);

        for (m in monsters) {
            if (m.x == x && m.y == y)
                return (false);
        }
        return (true);
    }

    public function move(mWalls:FlxTilemap, monsters:FlxTypedGroup<monsters.Monster>):Void {
        var arr:Array<Int> = [-1, -1, -1, -1];

        if (_cooldown && _spawning)
            _spawning = false;
        else if (_cooldown) {
            var diff_x:Float = _player.x - x;
            var diff_y:Float = _player.y - y;
            if (checkEntity(x, y - 8, mWalls, monsters))
                arr[0] = 3;
            if (checkEntity(x + 8, y, mWalls, monsters))
                arr[1] = 0;
            if (checkEntity(x, y + 8, mWalls, monsters))
                arr[2] = 2;
            if (checkEntity(x - 8, y, mWalls, monsters))
                arr[3] = 1;

            trace(arr);
            
            if (diff_x == 0 && diff_y < 0 && arr[0] != null)
                    _dir = 3;
            else if (diff_x == 0 && diff_y > 0 && arr[2] != null)
                    _dir = 2;
            else if (diff_y == 0 && diff_x < 0 && arr[3] != null)
                    _dir = 1;
            else if (diff_y == 0 && diff_x > 0 && arr[1] != null)
                    _dir = 0;

            else if (diff_x > 0 && arr[1] != -1)
                _dir = 0;
            else if (diff_y > 0 && arr[2] != -1)
                _dir = 2;    
            else if (diff_x < 0 && arr[3] != -1)
                _dir = 1;
            else if (diff_y < 0 && arr[0] != -1)
                _dir = 3;
            else {
                for (i in 0...4) {
                    if (arr[i] != -1)
                        _dir = arr[i];
                }
            }

            _isMoving = true;
            _cooldown = false;
        }
    }

    public function repulse(x:Float, y:Float):Void {
        setPosition(x, y);
    }

    // public function repulse(dir:Int):Void {
    //     _isMoving = true;
    //     _dir = dir;
    // }
}

enum Direction {TOP; LEFT; DOWN; RIGHT;}