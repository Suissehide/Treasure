package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;

class PlayState extends FlxState
{
	var _map:Level;

    var _player:Player;
    var _monsters:FlxTypedGroup<monsters.Monster>;

	var _objects:FlxGroup;

    var _gameCamera:FlxCamera;
    var _uiCamera:FlxCamera;
    
    /* Game mechanics */
    var _turn:Int = 0;
    var _who:Bool = true;
    var _maxSpawn:Int = 3;
    var _spawnrate:Int = 6;
    var _pop:Bool = true;


    var _hud:Hud;
	var _fading:Bool;

	override public function create():Void
	{
        _monsters = new FlxTypedGroup<monsters.Monster>();
        _player = new Player(0, 0);
        _map = new Level(_player, _monsters);
    
        _hud = new Hud();

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


		// if (FlxG.sound.music == null)
			// FlxG.sound.playMusic(FlxAssets.getSound("assets/sounds/ost"), 0.3);

		FlxG.cameras.flash(0xff131c1b, 0.65);
		_fading = false;

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
        // Collisions with environment
		FlxG.collide(_objects, _map._mWalls);

        generateMonsters();

        if (_who) {
            _player.getInput(_map._mWalls);
            FlxG.overlap(_player, _monsters, checkPlayer);
        }
        else {
            for (m in _monsters)
                m.move(_map._mWalls);
            FlxG.overlap(_monsters, _player, checkMonster);
        }
        if (!_player._isMoving && !_player._cooldown) {
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

        // Lose menu
		if (!_player.alive)
			FlxG.switchState(new LoseState());

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

	function checkPlayer(p:Player, e:monsters.Monster):Void {
		e.kill();
	}

	function checkMonster(e:monsters.Monster, p:Player):Void {
		p.kill();
	}

    function generateMonsters() {
        if (_turn % _spawnrate == 0 && _pop) {
            for (i in 0..._maxSpawn) {
                var monster = _monsters.recycle(monsters.Zombie.new.bind(0, 0, _player));
                var r:FlxPoint = _map._mFloor.getTileCoordsByIndex(_map._spawn[FlxG.random.int(0, _map._spawn.length - 1)]);
                monster.init(r.x - 4, r.y - 4);
            }
            _pop = false;
        }
    }
}
