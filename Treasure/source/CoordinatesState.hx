package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import sys.io.File;
import sys.FileSystem;

class CoordinatesState extends FlxState {
    var _scroll:FlxSprite;
    var _background:FlxSprite;
    var _text:FlxText;
    var _continue:FlxText;

	override public function create():Void {
        _scroll = new FlxSprite();
        _scroll.loadGraphic("assets/images/scroll.png", false, 2600, 1709);
        _scroll.scale.set(0.78, 0.78);
        _scroll.screenCenter();
        _scroll.x = -550;
        _text = new FlxText(0, 0);
        _text.text = sys.io.File.getContent("assets/data/place.txt");
        _text.setFormat("assets/fonts/Stardew_Valley.otf");
        _text.color = FlxColor.LIME;
        _text.size = 40;
        _text.screenCenter();
        _continue = new FlxText(0,0);
        _continue.text = "press any key to continue";
        _continue.setFormat("assets/fonts/Stardew_Valley.otf");
        _continue.color = FlxColor.LIME;
        _continue.size = 25;
        _continue.screenCenter();
        _continue.y = 800;
        add(_scroll);
        add(_text);
        add(_continue);
		super.create();
	}

	override public function update(elapsed:Float):Void {
        _scroll.animation.play("magicScroll");
        if (FlxG.keys.pressed.ANY) {
            FlxG.switchState(new PlayState());
        }
        super.update(elapsed);
	}
}
