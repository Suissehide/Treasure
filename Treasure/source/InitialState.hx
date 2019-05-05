package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class InitialState extends FlxState {
	var _btnPlay:FlxButton;
	var _background:FlxSprite;
	var _title:FlxText;
	var _continue:FlxText;

	override public function create():Void {
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end
		_background = new FlxSprite();
		_background.loadGraphic("assets/images/garden.jpg", false, 1600, 900);
		/*_btnPlay = new FlxButton(0,0, "", clickPlay);
			_btnPlay.scale.set(4,4);
			 _btnPlay.updateHitbox();
			_btnPlay.screenCenter();
			_btnPlay.y = 600;
			_btnPlay.updateHitbox(); */
		_continue = new FlxText(0, 0);
		_continue.text = "press any key to continue";
		_continue.setFormat("assets/fonts/Stardew_Valley.otf");
		_continue.color = FlxColor.WHITE;
		_continue.size = 25;
		_continue.screenCenter();
		_continue.y = 800;
		_title = new FlxText(0, 0);
		_title.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n";
		_title.setFormat("assets/fonts/Sartdew_Valley.otf");
		_title.color = FlxColor.WHITE;
		_title.size = 50;
		_title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.LIME, 2);
		_title.screenCenter();
		_title.y = 100;
		add(_background);
		add(_title);
		add(_btnPlay);
		add(_continue);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		if (FlxG.keys.pressed.ANY) {
			FlxG.camera.fade(FlxColor.GREEN, .33, false, function() {
				FlxG.switchState(new MenuState());
			});
		}
		super.update(elapsed);
	}
}
