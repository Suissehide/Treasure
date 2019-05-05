package monsters;

import flixel.FlxG;
import flixel.FlxObject;

class Zombie extends Monster {
	static inline var TILE_WIDTH:Int = 8;

	var _invincible:Bool = true;

	override public function new(X:Int, Y:Int, Player:Player) {
		super(X, Y);

		loadGraphic("assets/images/zombie.png", true, 8, 8);

		_player = Player;

		_speed = 1;
		_isMoving = false;
		_distance = 0;
		// playerPos = FlxPoint.get();

		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("idle", [0], 10, true);
		animation.add("walk", [0, 1], 10, true);
		animation.add("death", [3], 1, true);
		animation.add("pop", [2], 20, true);
	}

	override public function update(elapsed:Float):Void {
		if (_distance >= TILE_WIDTH) {
			_distance = 0;
			_isMoving = false;
		}
		if (_isMoving) {
			_distance += 1;
			switch (_dir) {
				case 0:
					setPosition(x + _speed, y);
				case 1:
					setPosition(x - _speed, y);
				case 2:
					setPosition(x, y + _speed);
				case 3:
					setPosition(x, y - _speed);
			}
			last.set(x, y);
			animation.play("walk");
		} else if (_spawning) {
			animation.play("pop");
		} else
			animation.play("idle");
		super.update(elapsed);
	}

	override public function draw():Void {
		if (velocity.x > 0)
			facing = FlxObject.LEFT;
		else
			facing = FlxObject.RIGHT;

		super.draw();
	}

	override public function kill():Void {
		if (!alive)
			return;
		// FlxG.sound.play(FlxAssets.getSound("assets/sounds/asplode"));
		animation.play("death");
		super.kill();
	}
}
