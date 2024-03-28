package fallmon.states.menus;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;
import fallmon.subStates.menus.*;

class ConfigurationState extends FlxState
{
	private var menuTxt:FlxText;
	private var currentOption:Int = 0;
	private var descriptionTxt:FlxText;
	private var subOption:String = '';
	var menuTitle:FlxText;

	var preferencesSettings:Array<String> = ['debug mode'];
	var appearanceSettings:Array<String> = ['smooth filter'];

	var categories:Array<String> = ['preferences', 'appearance', 'exit'];

	override public function create():Void
	{
		subOption = '';

		menuTxt = new FlxText(20, 0, FlxG.width, "", 20);
		menuTxt.setFormat("Share Tech Mono", 26, FlxColor.WHITE, CENTER);
		menuTxt.screenCenter(Y);
		add(menuTxt);

		menuTitle = new FlxText(20, 150, FlxG.width, "CONFIGURATION", 20);
		menuTitle.setFormat("Share Tech Mono", 40, FlxColor.WHITE, CENTER);
		menuTitle.screenCenter(X);
		add(menuTitle);

		descriptionTxt = new FlxText(20, 450, FlxG.width, "", 20);
		descriptionTxt.setFormat("Share Tech Mono", 18, FlxColor.WHITE, LEFT);
		add(descriptionTxt);

		FlxG.camera.fade(FlxColor.BLACK, 0.2, true);

		super.create();
	}

	var seperator:String = '\n';

	override public function update(elapsed:Float)
	{
		switch (subOption)
		{
			case 'preferences':
				menuTxt.text = (currentOption == 0 ? '> ' : '') + 'Debug Mode: ${Init.debugMode}';

				if (currentOption >= appearanceSettings.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = appearanceSettings.length - 1;
			case 'appearance':
				menuTxt.text = (currentOption == 0 ? '> ' : '') + 'Smooth Filter: ${Init.globalAnti}';

				if (currentOption >= appearanceSettings.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = appearanceSettings.length - 1;
			default:
				menuTxt.text = (currentOption == 0 ? '> ' : '') + 'PREFERENCES' + seperator + (currentOption == 1 ? '> ' : '') + 'APPEARANCE' + seperator
					+ (currentOption == 2 ? '> ' : '') + 'EXIT';

				if (currentOption >= categories.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = categories.length - 1;
		}

		menuTitle.antialiasing = Init.globalAnti;
		menuTxt.antialiasing = Init.globalAnti;
		menuTxt.screenCenter();

		if (FlxG.keys.justPressed.DOWN)
			changeOptions(1);

		if (FlxG.keys.justPressed.UP)
			changeOptions(-1);

		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
			confirmAction();

		if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE)
			goBack();

		super.update(elapsed);
	}

	function changeOptions(?value:Int = 0)
	{
		FlxG.sound.play(AssetPaths.sound('menus/select'));
		currentOption += value;

		descriptionTxt.text = '';
	}

	function confirmAction()
	{
		FlxG.sound.play(AssetPaths.sound('terminal/confirmMenu'));
		switch (subOption)
		{
			case 'preferences':
				switch (appearanceSettings[currentOption])
				{
					case 'debug mode':
						FlxG.save.data.debugMode = !FlxG.save.data.debugMode;
				}
			case 'appearance':
				switch (appearanceSettings[currentOption])
				{
					case 'smooth filter':
						FlxG.save.data.globalAntialiasing = !FlxG.save.data.globalAntialiasing;
				}
			default:
				switch (categories[currentOption])
				{
					case 'exit':
						exitState('exit');
					default:
						subOption = categories[currentOption];
				}
				currentOption = 0;
		}
		Init.saveSettings();
	}

	function goBack()
	{
		FlxG.sound.play(AssetPaths.sound('terminal/changeMenu'));
		descriptionTxt.text = '';
		switch (subOption)
		{
			case '':
				exitState('exit');
			default:
				currentOption = 0;
				subOption = '';
		}
	}

	public function exitState(swapState:String)
	{
		trace('exiting menu');
		// Delete objects

		// Then swap state
		FlxG.camera.fade(FlxColor.BLACK, 0.2, false, function()
		{
			Main.switchState(this, new MainMenuState());
		});
	}
}
