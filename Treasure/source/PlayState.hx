package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;

class PlayState extends FlxState
{

    var _player:Player;
    var _monsters:FlxTypedGroup<monsters.Monster>;

	var _objects:FlxGroup;

    var _gameCamera:FlxCamera;
    var _uiCamera:FlxCamera;
    
    /* Game mechanics */
    var _who:Bool = true;
    var _maxSpawn:Int = 2;
    var _spawnrate:Int = 20;
    var _pop:Bool = true;
    var _m:monsters.Monster = null;
    var _kill:Bool = false; 

    var _hud:Hud;
	var _fading:Bool;

	public var _turn:Int = 0;
	public var _map:Level;

	override public function create():Void
	{
        _monsters = new FlxTypedGroup<monsters.Monster>();
        _player = new Player(0, 0);
        _map = new Level(_player, _monsters);
    
        _hud = new Hud(_player, this);

		add(_map._mWalls);
        add(_map._mFloor);
		add(_player);
        add(_monsters);
        add(_hud);

        _objects = new FlxGroup();
        _objects.add(_monsters);
		_objects.add(_player);

        /* Cameras */
        _gameCamera = new FlxCamera(0, 0, 1600, 900);
        _uiCamera = new FlxCamera(0, 0, 1600, 900);

        _gameCamera.bgColor = 0xff191716;
        _uiCamera.bgColor = FlxColor.TRANSPARENT;

        _gameCamera.follow(_player);
        _gameCamera.zoom = 4;

        FlxG.cameras.reset(_gameCamera);
        FlxG.cameras.add(_uiCamera);

        FlxCamera.defaultCameras = [_gameCamera];
		_uiCamera.follow(_player);
        _hud.cameras = [_uiCamera];


		if (FlxG.sound.music == null)
		    FlxG.sound.playMusic(FlxAssets.getSound("assets/sounds/Celestial"), 0.3);

		FlxG.cameras.flash(0xff131c1b, 0.65);
		_fading = false;

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
        // Collisions with environment
		FlxG.collide(_objects, _map._mWalls);

        super.update(elapsed);
        generateMonsters();

        if (_who) {
            _player.getInput(_map._mWalls);
            FlxG.overlap(_player, _monsters, checkPlayer);
        }
        else {
            for (m in _monsters) {
                m.move(_map._mWalls, _monsters);
            }
            FlxG.overlap(_monsters, _player, checkMonster);
        }
        if (!_player._isMoving && !_player._cooldown) {
            repulse();
            _player._cooldown = true;
            _turn += 1;
            _pop = true;
            _who = false;
        }
        for (m in _monsters) {
            if (!m._isMoving && !m._cooldown) {
                m._cooldown = true;
                _who = true;
            }
        }
        if (_monsters.countLiving() == 0)
            _who = true;

        // Lose menu
		if (!_player._alive) {
            FlxG.camera.fade(FlxColor.BLACK, .33, false, function() {
			    FlxG.switchState(new LoseState());
            });
        }

        // Main menu
		#if FLX_KEYBOARD
		if (FlxG.keys.pressed.ESCAPE)
			FlxG.switchState(new MenuState());
		#end

        super.update(elapsed);
    }

    override public function destroy():Void {

		_player = null;
		_monsters = null;
		_objects = null;

		_map = null;

		super.destroy();
	}

    function getMonster(x:Float, y:Float):Bool {
        for (m in _monsters) {
            if (m.x == x && m.y == y) {
                _m = m;
                return true;
            }
        }
        _m = null;
        return false;
    }

    function isEmpty(x:Float, y:Float):Bool {
        if (!_m.checkEntity(x, y, _map._mWalls, _monsters)) {
            _player.kill();
            return (true);
        }
        return (false);
    }

    function repulseMonster(i:Int)
    {
        switch i {
            case 0: if (getMonster(_player.x, _player.y - TILE_WIDTH) &&
                    isEmpty(_player.x, _player.y - 2 * TILE_WIDTH))
                        _m.repulse(_player.x, _player.y - 2 * TILE_WIDTH);
            case 2: if (getMonster(_player.x  - TILE_WIDTH, _player.y) &&
                    isEmpty(_player.x - 2 * TILE_WIDTH, _player.y))
                        _m.repulse(_player.x - 2 * TILE_WIDTH, _player.y);
            case 4: if (getMonster(_player.x, _player.y + TILE_WIDTH) &&
                    isEmpty(_player.x, _player.y + 2 * TILE_WIDTH))
                        _m.repulse(_player.x, _player.y + 2 * TILE_WIDTH);
            case 6: if (getMonster(_player.x + TILE_WIDTH, _player.y) &&
                    isEmpty(_player.x + 2 * TILE_WIDTH, _player.y))
                        _m.repulse(_player.x + 2 * TILE_WIDTH, _player.y);
        }
    }

    function repulse() {
        if (_kill) {
            for (i in 0...8)
                repulseMonster(i);
            _kill = false;
        }
    }

	function checkPlayer(p:Player, e:monsters.Monster):Void {
		e.kill();
        _kill = true;
	}

	function checkMonster(e:monsters.Monster, p:Player):Void {
		p.kill();
	}

    function generateMonsters() {
        if (_turn % _spawnrate == 0 && _pop) {
            for (i in 0..._maxSpawn) {
                var monster = _monsters.add(new monsters.Zombie(0, 0, _player));
                // var monster = _monsters.recycle(monsters.Zombie.new.bind(0, 0, _player));
                var r:FlxPoint = _map._mFloor.getTileCoordsByIndex(_map._spawn[FlxG.random.int(0, _map._spawn.length - 1)]);
                monster.init(r.x - 4, r.y - 4);
            }
            _pop = false;
        }
    }
}
