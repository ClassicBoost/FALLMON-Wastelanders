package fallmon.gameObjects.userInterface;

import fallmon.backend.*;
import fallmon.gameObjects.*;
import fallmon.states.*;
import fallmon.subStates.*;

class ClassHUD extends FlxTypedGroup<FlxBasic>
{
	var healthTxt:FlxText;
	var hpPercent:Float = 100;

	// eep
	public function new()
	{
		super();

		var cornerText:FlxText = new FlxText(0, 0, 0, '${Main.gameVersion}\nUraniumEngine');
		cornerText.setFormat(8, FlxColor.WHITE, LEFT);
		add(cornerText);

		healthTxt = new FlxText(5, 570, 0, '');
		healthTxt.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, LEFT);
		add(healthTxt);
	}

	override public function update(elapsed:Float)
	{
		updateText();

		super.update(elapsed);
	}

	public function updateText()
	{
		hpPercent = Std.int((PlayState.health / Player.maxHealth) * 100);
		healthTxt.text = '${Player.characterName} - HP: ${Std.int(PlayState.health)}/${Player.maxHealth}';
		// healthTxt.text += ' ($hpPercent%)';

		if (hpPercent <= 20)
			healthTxt.color = 0xFFFF1E26; // Careful now...
		else
			healthTxt.color = 0xFFFFFFFF;
	}
}
