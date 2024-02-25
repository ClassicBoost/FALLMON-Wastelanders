package fallmon.gameObjects.userInterface;

import fallmon.backend.*;
import fallmon.states.*;
import fallmon.subStates.*;

class DebugHUD extends FlxTypedGroup<FlxBasic>
{
	var debugTxt:FlxText;

	// eep
	public function new()
	{
		super();

		debugTxt = new FlxText(5, 16, 0, 'hey vsauce michael here', 8);
		add(debugTxt);
	}

	override public function update(elapsed:Float)
	{
		debugTxt.text = '${Main.gameVersion}\n';

		debugTxt.text += '\nhealth: ${PlayState.health}\nmaxHealth: ${PlayState.maxHealth}\n';
		debugTxt.text += '\nstamina: ${PlayState.stamina}\nmaxStamina: ${PlayState.maxStamina}\n';
		debugTxt.text += '\npp: ${PlayState.pp}\nmaxPP: ${PlayState.maxPP}\n';

		debugTxt.text += '\n';
	}
}
