package;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class Level
{
    /**
	 * Some static constants for the size of the tilemap tiles
	 */
	static inline var TILE_WIDTH:Int = 8;
	static inline var TILE_HEIGHT:Int = 8;

	public var _mWalls:FlxTilemap;
    public var _mFloor:FlxTilemap;
    public var _spawn:Array<Int> = [];
    public var _chest:Array<Float>;

    var _map:FlxOgmoLoader;
    var _player:Player;
    var _monsters:FlxTypedGroup<monsters.Monster>;

    public function new(player:Player, monsters:FlxTypedGroup<monsters.Monster>) {
        // super();

        var array:Array<Int>;

        _player = player;
        _monsters = monsters;

		// Basic level structure
		_map = new FlxOgmoLoader("assets/data/level-1.oel");
		_mWalls = _map.loadTilemap("assets/images/tiles.png", 8, 8, "walls");
		_mWalls.follow();
        for (i in 1...120)
            _mWalls.setTileProperties(i, FlxObject.ANY);

        _mFloor = _map.loadTilemap("assets/images/tiles.png", 8, 8, "floor");
		for (i in 1...120)
            _mFloor.setTileProperties(i, FlxObject.NONE);

        for (i in 1...120) {
            array = _mFloor.getTileInstances(i);
            if (array != null)
                _spawn = _spawn.concat(array);
        }

		_map.loadEntities(placeEntities, "entities");
    }

    function placeEntities(entityName:String, entityData:Xml):Void {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));
        if (entityName == "player") {
            _player.x = x;
            _player.y = y;
        }
        if (entityName == "chest") {
            _chest[0] = x;
            _chest[1] = y;
        }
    }
}