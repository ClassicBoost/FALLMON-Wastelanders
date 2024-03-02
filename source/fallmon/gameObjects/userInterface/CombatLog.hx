package fallmon.gameObjects.userInterface;

class CombatLog extends FlxTypedGroup<FlxBasic>
{
	public var theLogs:FlxText;
	public var displayTxt:String;
	public var numberOfLines:Int = 0;

	// eep
	public function new()
	{
		super();

		theLogs = new FlxText(20, 25, 750, 'TEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\nTEXT\n');
		theLogs.setFormat(AssetPaths.font('terminal.ttf'), 20, MainMenuState.bgcolorshit, LEFT);
		theLogs.antialiasing = Init.globalAnti;
		theLogs.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.5);
		add(theLogs);

		numberOfLines = 0;
	}

	override public function update(elapsed:Float)
	{
		theLogs.text = displayTxt;

		super.update(elapsed);
	}

	public function combatStatus(enter:Bool = true)
	{
		FlxTween.cancelTweensOf(theLogs);
		FlxTween.tween(theLogs, {alpha: (enter ? 1 : 0)}, 1, {ease: FlxEase.linear});
	}

	public function updateText(text:String, ?reset:Bool = false)
	{
		if (reset || numberOfLines > 16)
		{
			displayTxt = '';
			numberOfLines = 0;
		}

		displayTxt += '$text\n';
		if (text != '')
			numberOfLines++;
	}
}
