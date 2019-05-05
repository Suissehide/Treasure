package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;

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
    

    // var _hud:Hud;
	var _fading:Bool;

	override public function create():Void
	{
        _monsters = new FlxTypedGroup<monsters.Monster>();
        _player = new Player(0, 0);
        _map = new Level(_player, _monsters);
    
        // _hud = new Hud(_player);

		add(_map._mWalls);
        add(_map._mFloor);
		add(_player);
        // add(_hud);

        _objects = new FlxGroup();
        _objects.add(_monsters);
		_objects.add(_player);

        /* Cameras */
        _gameCamera = new FlxCamera(0, 0, 1600, 900);
        _uiCamera = new FlxCamera(0, 0, 1600, 900);

        _gameCamera.bgColor = 0xff626a71;
        _uiCamera.bgColor = FlxColor.TRANSPARENT;

        _gameCamera.follow(_player);
        _gameCamera.zoom = 2;

        FlxG.cameras.reset(_gameCamera);
        FlxG.cameras.add(_uiCamera);

        FlxCamera.defaultCameras = [_gameCamera];
        // hudElement.cameras = [_uiCamera];


		// if (FlxG.sound.music == null)
			// FlxG.sound.playMusic(FlxAssets.getSound("assets/sounds/ost"), 0.3);

		FlxG.cameras.flash(0xff131c1b);
		_fading = false;

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
        // Collisions with environment
		// FlxG.collide(_objects, _map._mWalls);
        FlxG.overlap(_player, _monsters, checkPlayer);
        FlxG.overlap(_monsters, _player, checkMonster);

        _player.getInput(_map._mWalls);

        generateMonsters();

        // Lose menu
		// if (!_player.alive)
			// FlxG.switchState(new LoseState());

        // Main menu
		// #if FLX_KEYBOARD
		// if (FlxG.keys.pressed.ESCAPE)
			// FlxG.switchState(new MenuState());
		// #end
	
        if (!_player.cooldown_anim)
            _player.cooldown = true;
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
        // array = getTileCoords(Index:Int);
    }
}
