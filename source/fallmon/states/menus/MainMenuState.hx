package fallmon.states.menus;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;

class MainMenuState extends FlxState
{
	// hi
	override public function create():Void
	{
		super.create();

		// MOVE THIS LATER
		PlayState.resetStats(true);
		Main.switchState(this, new PlayState());
	}
}
