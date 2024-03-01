package fallmon.gameObjects.userInterface;

class CombatLog extends FlxTypedGroup<FlxBasic>
{
	public var theLogs:FlxText;

	// eep
	public function new()
	{
		super();

		theLogs = new FlxText(20, 25, 750, 'TEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\n');
		theLogs.setFormat(AssetPaths.font('terminal.ttf'), 20, MainMenuState.bgcolorshit, LEFT);
		theLogs.antialiasing = Init.globalAnti;
		theLogs.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.5);
		add(theLogs);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function combatStatus(enter:Bool = true)
	{
		FlxTween.cancelTweensOf(theLogs);
		FlxTween.tween(theLogs, {alpha: (enter ? 1 : 0)}, 1, {ease: FlxEase.linear});
	}
}
