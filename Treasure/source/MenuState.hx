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

class MenuState extends FlxState {
	var _text:FlxText;
    var _continue:FlxText;
    var _background:FlxSprite;
    var _scroll:FlxSprite;
   
	override public function create():Void {
        _background = new FlxSprite();
		_background.loadGraphic("assets/images/MenuBackground.png", false, 1600, 900);
        _scroll = new FlxSprite();
        _scroll.loadGraphic("assets/images/magicScroll.png", true, 160, 160);
        _scroll.animation.add("magicScroll", [0, 1, 2, 3, 4, 32, 33, 34, 35, 36, 37, 36, 35, 34, 33, 32], 15, true);
        _scroll.scale.set(0.5, 0.5);
        _scroll.y = 740;
        _scroll.x = 1400;
        _text = new FlxText(0, 0);
        _text.text = sys.io.File.getContent("assets/data/menustate.txt");
        _text.setFormat("assets/fonts/Stardew_Valley.otf");
        _text.color = FlxColor.BROWN;
        _text.size = 40;
        _text.screenCenter();
        _text.y = 250; 
        _continue = new FlxText(0,0);
        _continue.text = "press any key to continue";
        _continue.setFormat("assets/fonts/Stardew_Valley.otf");
        _continue.color = FlxColor.BROWN;
        _continue.size = 25;
        _continue.screenCenter();
        _continue.y = 800;
        add(_background);
        add(_text);
        add(_continue);
        add(_scroll);
        super.create();
	}

	override public function update(elapsed:Float):Void {
        _scroll.animation.play("magicScroll");
        if (FlxG.keys.pressed.ANY) {
            FlxG.switchState(new CoordinatesState());
        }
        super.update(elapsed);
	}

	override public function destroy():Void {
		super.destroy();
	}
}