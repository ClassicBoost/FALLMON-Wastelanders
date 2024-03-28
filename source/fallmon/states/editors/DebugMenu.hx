package fallmon.states.editors;

class DebugMenu extends FlxState
{
	override public function create():Void
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ESCAPE)
			Main.switchState(this, new MainMenuState());

		super.update(elapsed);
	}
}
