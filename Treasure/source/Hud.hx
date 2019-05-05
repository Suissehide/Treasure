package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import Math;

class Hud extends FlxTypedGroup<FlxButton> {
    var _waitButton:FlxButton;
    var _infoButton:FlxButton;
    var _playButton:FlxButton;
    var _digButton:FlxButton;
    var _turnNumber:FlxText;

    public function new() {
        super();
        _playButton = new FlxButton(900, 450);
        _playButton.loadGraphic("assets/images/button2.png", true, 350, 154);
        _playButton.scale.set(0.2, 0.2);
        _playButton.updateHitbox();
        add(_playButton);
        forEach(function(spr:FlxButton) {
			spr.scrollFactor.set(0, 0);
		});
    }

    override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}