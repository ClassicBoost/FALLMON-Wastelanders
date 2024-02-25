package fallmon.gameObjects.userInterface;

import fallmon.backend.*;
import fallmon.states.*;
import fallmon.subStates.*;

class ClassHUD extends FlxTypedGroup<FlxBasic>
{
	var healthTxt:FlxText;

	// eep
	public function new()
	{
		super();

		var cornerText:FlxText = new FlxText(0, 0, 0, '${Main.gameVersion}');
		cornerText.setFormat(12, FlxColor.WHITE, LEFT);
		add(cornerText);

		healthTxt = new FlxText(5, 570, 0, '');
		healthTxt.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, LEFT);
		add(healthTxt);
	}

	override public function update(elapsed:Float)
	{
		healthTxt.text = 'HP: ${PlayState.health}/${PlayState.maxHealth}';
	}
}
