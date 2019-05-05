package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import Math;

class Hud extends FlxTypedGroup<FlxSprite> {
    var _waitButton:FlxButton;
    var _infoButton:FlxButton;
    var _passButton:FlxButton;
    var _digButton:FlxButton;
    var _turnNumber:FlxText;
    var _player:Player;
    var _turn:PlayState;
    var _pos:Float;

    public function new(Player:Player, Turn:PlayState) {
        super();
        _turn = Turn;
        _player = Player;
        _turnNumber = new FlxText((((_player.x) * 8) - 290), (((_player.y) * 8) + 20), 0, "");
        _turnNumber.setFormat("assets/fonts/Sartdew_Valley.otf");
        _turnNumber.size = 15;
        _infoButton = new FlxButton((((_player.x) *8) - 290), (((_player.y) * 8) + 210), "");
        _infoButton.loadGraphic("assets/images/buttonInfo.png", true, 175, 154);
        _infoButton.scale.set(0.2, 0.2);
        _infoButton.updateHitbox();
        _passButton = new FlxButton((((_player.x) *8) - 290), (((_player.y) * 8) + 170), "");
        _passButton.loadGraphic("assets/images/buttonPass.png", true, 175, 154);
        _passButton.scale.set(0.2, 0.2);
        _passButton.updateHitbox();
        _digButton = new FlxButton((((_player.x) *8) - 290), (((_player.y) * 8) + 130), "");
        _digButton.loadGraphic("assets/images/buttonShovel.png", true, 175, 154);
        _digButton.scale.set(0.2, 0.2);
        _digButton.updateHitbox();
        add(_passButton);
        add(_digButton);
        add(_infoButton);
        add(_turnNumber);

        forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set(0, 0);
		});
    }

    override public function update(elapsed:Float):Void {
        _turnNumber.text = "Turn: " + _turn._turn;
		super.update(elapsed);
	}
}