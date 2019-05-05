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

	override public function create():Void {
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end
    _background = new FlxSprite();
		_background.loadGraphic("assets/images/HomeBackground.jpg", true, 1600, 900);
    _btnPlay = new FlxButton(0,0, "", clickPlay);
    _btnPlay.scale.set(4,4);
     _btnPlay.updateHitbox();
    _btnPlay.screenCenter();
    _btnPlay.y = 600;
    _btnPlay.updateHitbox();
		_title = new FlxText(0, 0);
		_title.text = "GRANDPA'S TREASURE HUNT SUPER NIBBA";
		_title.scale.set(7, 7);
		_title.color = FlxColor.LIME;
		_title.screenCenter();
		_title.y = 100;
		add(_background);
		add(_title);
    add(_btnPlay);
		super.create();
	}

	function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BROWN, .33, false, function() {
			FlxG.switchState(new MenuState());
		});
	}
}
