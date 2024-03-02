package fallmon.states.menus;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.editors.*;
import fallmon.states.menus.*;
import fallmon.subStates.menus.*;

class MainMenuState extends FlxState
{
	private var menuTxt:FlxText;
	private var currentOption:Int = 0;
	private var subOption:String = '';
	var menuTitle:FlxText;

	public static var bgcolorshit:FlxColor = 0xFF1EFF8B;

	var options:Array<String> = ['play', 'credits', 'options', 'help'];

	// hi
	override public function create():Void
	{
		subOption = '';

		menuTxt = new FlxText(20, 0, FlxG.width, "", 20);
		menuTxt.setFormat(26, FlxColor.WHITE, LEFT);
		menuTxt.screenCenter(Y);
		add(menuTxt);

		menuTitle = new FlxText(20, 200, FlxG.width, "", 20);
		menuTitle.setFormat("VCR OSD Mono", 40, FlxColor.WHITE, LEFT);
		add(menuTitle);

		FlxG.camera.fade(FlxColor.BLACK, 0.2, true);

		super.create();
	}

	var seperator:String = '\n';

	override public function update(elapsed:Float)
	{
		//	bgTrees.x += 50 * elapsed;
		//	bgGrass.x += 40 * elapsed;

		switch (subOption)
		{
			default:
				menuTxt.text = (currentOption == 0 ? '> ' : '') + 'PLAY' + seperator + (currentOption == 1 ? '> ' : '') + 'CREDITS' + seperator
					+ (currentOption == 2 ? '> ' : '') + 'OPTIONS' + seperator + (currentOption == 3 ? '> ' : '') + 'HELP' + seperator;
				//	+ (currentOption == 3 ? '> ' : '')
				//	+ 'ERASE SAVE';
				menuTitle.text = 'FALLMON Wastelanders';
		}

		menuTxt.antialiasing = Init.globalAnti;
		menuTitle.antialiasing = Init.globalAnti;

		if (FlxG.keys.justPressed.DOWN)
			changeOptions(1);

		if (FlxG.keys.justPressed.UP)
			changeOptions(-1);

		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
			confirmAction();

		if (currentOption >= options.length)
			currentOption = 0;
		if (currentOption < 0)
			currentOption = options.length - 1;

		if (FlxG.keys.justPressed.SEVEN)
			Main.switchState(this, new SpeciesEditor());

		super.update(elapsed);
	}

	function changeOptions(?value:Int = 0)
	{
		FlxG.sound.play(AssetPaths.sound('menus/select'));
		currentOption += value;
	}

	function confirmAction()
	{
		FlxG.sound.play(AssetPaths.sound('menus/confirm'));
		switch (options[currentOption])
		{
			case 'play': // PLAY
				FlxG.camera.fade(FlxColor.BLACK, 0.2, false, function()
				{
					exitState('play');
				});
			case 'credits': // CREDITS
				openSubState(new CreditsSubState());
			case 'options': // OPTIONS
				FlxG.camera.fade(FlxColor.BLACK, 0.2, false, function()
				{
					exitState('options');
				});
			case 'help': // HELP
		}
	}

	public function exitState(swapState:String)
	{
		trace('exiting menu');
		// Delete objects

		// Then swap state
		switch (swapState)
		{
			case 'options':
				Main.switchState(this, new ConfigurationState());
			case 'play':
				//	PlayState.resetStats(true);
				//	Main.switchState(this, new PlayState());
				Main.switchState(this, new CharacterCreation());
			default:
				Main.switchState(this, new MainMenuState());
		}
	}
}
