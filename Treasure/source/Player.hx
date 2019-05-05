package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup.FlxTypedGroup;

class Player extends FlxSprite {
	public var _cooldown:Bool = true;

	var LENGTH_TILE:Float = 8;
	var SPEED:Float = 1;

	public var _isMoving:Bool = false;

	var direction_move:Int = 0;
	var number_anim:Float = 0;

	public function new(X:Float, Y:Float) {
		super(X, Y);

		loadGraphic("assets/images/player.png", true, 8, 8);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		animation.add("idle", [0], 10, true);
		animation.add("walk", [0, 1], 10, true);

		// set direct a true ou set a true quand on lance la partie
		// _cooldown = false;
	}

	public function getInput(mWalls:FlxTilemap):Void {
		if (_cooldown == true) {
			// movement allowed
			if (((FlxG.mouse.x > (x + LENGTH_TILE) && FlxG.mouse.x < (x + 2 * LENGTH_TILE) && FlxG.mouse.pressed)
				|| FlxG.keys.anyPressed([RIGHT, D]))
				&& !overlapsAt(x + LENGTH_TILE, y, mWalls)) {
				// go right
				facing = FlxObject.LEFT;
				_isMoving = true;
				direction_move = 0;
				_cooldown = false;
			} else if (((FlxG.mouse.x < x && FlxG.mouse.x > (x - LENGTH_TILE) && FlxG.mouse.pressed) || FlxG.keys.anyPressed([LEFT, Q]))
				&& !overlapsAt(x - LENGTH_TILE, y, mWalls)) {
				// go left
				facing = FlxObject.RIGHT;
				_isMoving = true;
				direction_move = 1;
				_cooldown = false;
			} else if (((FlxG.mouse.y > (y + LENGTH_TILE) && FlxG.mouse.y < (y + 2 * LENGTH_TILE) && FlxG.mouse.pressed)
				|| FlxG.keys.anyPressed([DOWN, S]))
				&& !overlapsAt(x, y + LENGTH_TILE, mWalls)) {
				// go down
				_isMoving = true;
				direction_move = 2;
				_cooldown = false;
			} else if (((FlxG.mouse.y < y && FlxG.mouse.y > (y - LENGTH_TILE) && FlxG.mouse.pressed) || FlxG.keys.anyPressed([UP, Z]))
				&& !overlapsAt(x, y - LENGTH_TILE, mWalls)) {
				// go up
				_isMoving = true;
				direction_move = 3;
				_cooldown = false;
			}
		}
	}

	override public function update(elapsed:Float):Void {
		if (_isMoving)
			animation.play("walk");
		else
			animation.play("idle");

		if (number_anim >= LENGTH_TILE) {
			number_anim = 0;
			_isMoving = false;
		}
		if (_isMoving == true) {
			number_anim = number_anim + 1;
			switch direction_move {
				case 0:
					setPosition(x + SPEED, y);
				case 1:
					setPosition(x - SPEED, y);
				case 2:
					setPosition(x, y + SPEED);
				case 3:
					setPosition(x, y - SPEED);
			}
		}

		super.update(elapsed);
	}

	override public function kill():Void {
		if (!alive)
			return;
		FlxSpriteUtil.flicker(this, 1, 0.04, true);
		super.kill();

        FlxG.camera.shake(0.007, 0.25);
		FlxG.camera.flash(0xffd8eba2, 0.65);
		FlxG.timeScale = 0.35;
	}
}
