package fallmon.backend;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;

class Init extends FlxState
{
	// bitch
	override public function create():Void
	{
		super.create();

		complete();
	}

	function complete()
	{
		Main.switchState(this, new MainMenuState());
	}
}
