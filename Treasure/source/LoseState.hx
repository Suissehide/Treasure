package;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.system.FlxAssets;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class LoseState extends FlxState
{
	var _sword:FlxSprite;
	var _gmTxt:FlxText;
	var _esc:FlxText;
	override public function create():Void
	{
		_esc = new FlxText(300, 800, 0, "Press R to Restart", 20);
        _esc.setFormat("assets/fonts/Stardew_Valley.otf");
        _esc.size = 20;
        _esc.screenCenter();
		add(_esc);

        FlxSpriteUtil.flicker(_esc, 0, 0.3, true);

		_gmTxt = new FlxText(300, 100, 0, "Game Over", 150);
        _gmTxt.setFormat("assets/fonts/Stardew_Valley.otf");
        _gmTxt.size = 100;
		_gmTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.RED, 2);
        _gmTxt.screenCenter();
        _gmTxt.y -= 100;
        add(_gmTxt);

		// _sword = new FlxSprite().loadGraphic("assets/images/GameOver.png");
		// _sword.scale.set(1.5,1.5);
		// _sword.screenCenter();
		// add(_sword);
        super.create();
	}

	override public function update(elapsed:Float):Void
	{
		#if FLX_KEYBOARD
		if (FlxG.keys.pressed.R)
			FlxG.switchState(new PlayState());
		#end
		super.update(elapsed);
	}
}