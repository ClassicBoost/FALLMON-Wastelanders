package fallmon.states;

import fallmon.backend.*;
import fallmon.gameObjects.*;
import fallmon.gameObjects.userInterface.*;
import fallmon.states.menus.*;

class DeadState extends FlxState
{
	var white:FlxSprite;

	var deadTxt:FlxText;

	var tickRate:Int = 60;

	override public function create()
	{
		white = new FlxSprite(0, 0).makeGraphic(3000, 3000, 0xFFFFFFFF);
		white.alpha = 0;
		add(white);

		deadTxt = new FlxText(0, 0, 0, 'YOU ARE DEAD...');
		deadTxt.setFormat("VCR OSD Mono", 40, FlxColor.BLACK, CENTER);
		deadTxt.alpha = 0;
		add(deadTxt);

		if (Player.characterAge < 16)
			deadTxt.text = 'GAME OVER';

		deadTxt.screenCenter();

		tickRate = 60;
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		tickRate--;

		if (tickRate < 0)
		{
			if (white.alpha >= 1)
				deadTxt.alpha += 0.01;
			else
				white.alpha += 0.01;

			if (tickRate < -500)
				Sys.exit(1);
			//  exitState();
		}
	}

	function exitState()
	{
		remove(deadTxt);
		remove(white);
		Main.switchState(this, new MainMenuState());
	}
}
