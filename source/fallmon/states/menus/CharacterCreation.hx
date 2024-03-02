package fallmon.states.menus;

import fallmon.*;
import fallmon.backend.*;
import fallmon.gameObjects.Player;
import fallmon.states.menus.*;
import fallmon.subStates.menus.NameCreator;

class CharacterCreation extends FlxState
{
	private var menuTxt:FlxText;
	private var descriptionTxt:FlxText;
	private var currentOption:Int = 0;
	private var subOption:String = '';
	var options:Array<String> = ['species', 'special', 'traits', 'others', 'start', 'exit'];

	// SUB OPTIONS
	var speciesOptions:Array<String> = ['pikachu', 'snivy', 'oshawott', 'tepig', 'axew'];
	var specialOptions:Array<String> = ['s', 'p', 'e', 'c', 'i', 'a', 'l'];
	var traitsOptions:Array<String> = [''];
	var othersOptions:Array<String> = ['name', 'age', 'gender'];

	var pointsRemaining:Int = 5;

	var speciesInfo:SpeciesShit;

	override public function create():Void
	{
		subOption = '';

		loadDefaultSpecies();

		menuTxt = new FlxText(20, 0, FlxG.width, "", 20);
		menuTxt.setFormat(26, FlxColor.WHITE, CENTER);
		add(menuTxt);

		descriptionTxt = new FlxText(20, 450, FlxG.width, "", 20);
		descriptionTxt.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, LEFT);
		add(descriptionTxt);

		FlxG.camera.fade(FlxColor.BLACK, 0.2, true);

		super.create();
	}

	var seperator:String = '\n';

	override public function update(elapsed:Float)
	{
		switch (subOption)
		{
			case 'species':
				if (currentOption >= speciesOptions.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = speciesOptions.length - 1;

				// Have a bad feeling that this might cause some lag
				speciesInfo = cast Json.parse(AssetPaths.getTextFromFile('data/species/pokemon/${speciesOptions[currentOption]}.json'));

				descriptionTxt.text = 'Type: ${speciesInfo.type.toUpperCase()}\n\n';

				descriptionTxt.text += 'STR ${speciesInfo.str} |'
					+ (speciesInfo.per != 0 ? ' PER ${speciesInfo.per} |' : '')
					+ ' END ${speciesInfo.end} | CHA ${speciesInfo.cha} | INT ${speciesInfo.int} | AGL ${speciesInfo.agl}'
					+ (speciesInfo.luk != 0 ? ' | LUK ${speciesInfo.luk}' : '');

				descriptionTxt.text += seperator + 'HP STM PP\n${speciesInfo.hp} ${speciesInfo.stamina} ${speciesInfo.pp}';
				descriptionTxt.text += seperator + 'RAD RESIST: ${speciesInfo.radresist}';
				descriptionTxt.text += seperator + 'AC: ${speciesInfo.ac}';

				menuTxt.text = (currentOption == 0 ? '> ' : '') + 'PIKACHU' + seperator + (currentOption == 1 ? '> ' : '') + 'SNIVY' + seperator
					+ (currentOption == 2 ? '> ' : '') + 'OSHAWOTT' + seperator + (currentOption == 3 ? '> ' : '') + 'TEPIG' + seperator
					+ (currentOption == 4 ? '> ' : '') + 'AXEW';
			case 'special':
				if (currentOption >= specialOptions.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = specialOptions.length - 1;

				menuTxt.text = (currentOption == 0 ? '< ' : '')
					+ 'STRENGTH: ${Player.str} (${(Player.str + speciesInfo.str)}) '
					+ (currentOption == 0 ? '>' : '');
				menuTxt.text += seperator
					+ (currentOption == 1 ? '< ' : '')
					+ 'PERCEPTION: ${Player.per} (${(Player.per + speciesInfo.per)}) '
					+ (currentOption == 1 ? '>' : '');
				menuTxt.text += seperator
					+ (currentOption == 2 ? '< ' : '')
					+ 'ENDURANCE: ${Player.end} (${(Player.end + speciesInfo.end)}) '
					+ (currentOption == 2 ? '>' : '');
				menuTxt.text += seperator
					+ (currentOption == 3 ? '< ' : '')
					+ 'CHARISMA: ${Player.cha} (${(Player.cha + speciesInfo.cha)}) '
					+ (currentOption == 3 ? '>' : '');
				menuTxt.text += seperator
					+ (currentOption == 4 ? '< ' : '')
					+ 'INTELLIGENCE: ${Player.int} (${(Player.int + speciesInfo.int)}) '
					+ (currentOption == 4 ? '>' : '');
				menuTxt.text += seperator
					+ (currentOption == 5 ? '< ' : '')
					+ 'AGILITY: ${Player.agl} (${(Player.agl + speciesInfo.agl)}) '
					+ (currentOption == 5 ? '>' : '');
				menuTxt.text += seperator
					+ (currentOption == 6 ? '< ' : '')
					+ 'LUCK: ${Player.luk} (${(Player.luk + speciesInfo.luk)}) '
					+ (currentOption == 6 ? '>' : '');
				menuTxt.text += seperator + '\nPOINTS LEFT: $pointsRemaining';
			case 'traits':
				menuTxt.text = '';
				if (currentOption >= traitsOptions.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = traitsOptions.length - 1;
			case 'others':
				menuTxt.text = (currentOption == 0 ? '> ' : '') + 'NAME: ${Player.characterName}' + seperator + (currentOption == 1 ? '< ' : '')
					+ 'AGE: ${Player.characterAge} ' + (currentOption == 1 ? '>' : '') + seperator + (currentOption == 2 ? '> ' : '')
					+ 'GENDER: ${Player.characterGender.toUpperCase()}' + seperator;

				if (currentOption >= othersOptions.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = othersOptions.length - 1;
			default:
				menuTxt.text = (currentOption == 0 ? '> ' : '')
					+ 'SPECIES (${(Player.characterSpecies == null ? '?' : '${Player.characterSpecies.toUpperCase()}')})'
					+ seperator
					+ (currentOption == 1 ? '> ' : '')
					+ 'SPECIAL'
					+ seperator
					+ (currentOption == 2 ? '> ' : '')
					+ 'TRAITS'
					+ seperator
					+ (currentOption == 3 ? '> ' : '')
					+ 'OTHERS\n'
					+ seperator
					+ (currentOption == 4 ? '> ' : '')
					+ 'START'
					+ seperator
					+ (currentOption == 5 ? '> ' : '')
					+ 'EXIT';

				if (currentOption >= options.length)
					currentOption = 0;
				if (currentOption < 0)
					currentOption = options.length - 1;
		}

		menuTxt.antialiasing = Init.globalAnti;
		menuTxt.screenCenter();

		if (FlxG.keys.justPressed.DOWN)
			changeOptions(1);

		if (FlxG.keys.justPressed.UP)
			changeOptions(-1);

		if (FlxG.keys.justPressed.LEFT)
			leftOrRight(false);
		if (FlxG.keys.justPressed.RIGHT)
			leftOrRight(true);

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

		if (subOption != 'species')
			descriptionTxt.text = '';
	}

	function leftOrRight(add:Bool)
	{
		switch (subOption)
		{
			case 'others':
				switch (othersOptions[currentOption])
				{
					case 'age':
						if (add)
						{
							if (Player.characterAge < 50)
								Player.characterAge++;
						}
						else
						{
							if (Player.characterAge > 10)
								Player.characterAge--;
						}
				}
			case 'special':
				switch (specialOptions[currentOption])
				{
					case 's':
						if (add)
						{
							if (Player.str < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.str++;
							}
						}
						else
						{
							if (Player.str > 1)
							{
								pointsRemaining++;
								Player.str--;
							}
						}
					case 'p':
						if (add)
						{
							if (Player.per < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.per++;
							}
						}
						else
						{
							if (Player.per > 1)
							{
								pointsRemaining++;
								Player.per--;
							}
						}
					case 'e':
						if (add)
						{
							if (Player.end < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.end++;
							}
						}
						else
						{
							if (Player.end > 1)
							{
								pointsRemaining++;
								Player.end--;
							}
						}
					case 'c':
						if (add)
						{
							if (Player.cha < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.cha++;
							}
						}
						else
						{
							if (Player.cha > 1)
							{
								pointsRemaining++;
								Player.cha--;
							}
						}
					case 'i':
						if (add)
						{
							if (Player.int < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.int++;
							}
						}
						else
						{
							if (Player.int > 1)
							{
								pointsRemaining++;
								Player.int--;
							}
						}
					case 'a':
						if (add)
						{
							if (Player.agl < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.agl++;
							}
						}
						else
						{
							if (Player.agl > 1)
							{
								pointsRemaining++;
								Player.agl--;
							}
						}
					case 'l':
						if (add)
						{
							if (Player.luk < 10 && pointsRemaining > 0)
							{
								pointsRemaining--;
								Player.luk++;
							}
						}
						else
						{
							if (Player.luk > 1)
							{
								pointsRemaining++;
								Player.luk--;
							}
						}
				}
		}
	}

	function confirmAction()
	{
		FlxG.sound.play(AssetPaths.sound('menus/confirm'));
		switch (subOption)
		{
			case 'special':
			case 'species':
				Player.characterSpecies = speciesOptions[currentOption];
				subOption = '';
				descriptionTxt.text = '';
				currentOption = 0;
				Player.characterProtrait = speciesInfo.protrait;
			case 'others':
				switch (othersOptions[currentOption])
				{
					case 'name':
						openSubState(new NameCreator());
					case 'gender':
						if (Player.characterGender == 'male') Player.characterGender = 'female'; else Player.characterGender = 'male';
				}
			default:
				switch (options[currentOption])
				{
					case 'start':
						if (Player.characterSpecies == null) descriptionTxt.text = 'Choose a species'; else if ((Player.str + speciesInfo.str <= 0)
							|| (Player.per + speciesInfo.per <= 0)
							|| (Player.end + speciesInfo.end <= 0)
							|| (Player.cha + speciesInfo.cha <= 0)
							|| (Player.int + speciesInfo.int <= 0)
							|| (Player.agl + speciesInfo.agl <= 0)
							|| (Player.luk + speciesInfo.luk <= 0))
							descriptionTxt.text = 'A SPECIAL stat is equal or lower than 0. Increase to at least 1.'; else exitState('play');
					case 'exit':
						exitState('exit');
					case 'species', 'special', 'traits', 'others':
						subOption = options[currentOption];
				}
				currentOption = 0;
		}
	}

	function goBack()
	{
		FlxG.sound.play(AssetPaths.sound('menus/cancel'));
		descriptionTxt.text = '';
		switch (subOption)
		{
			case '':
				exitState('exit');
			case 'species':
				loadDefaultSpecies();
				currentOption = 0;
				subOption = '';
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
			switch (swapState)
			{
				case 'play':
					PlayState.resetStats(false);
					Main.switchState(this, new PlayState());
				default:
					Main.switchState(this, new MainMenuState());
			}
		});
	}

	function loadDefaultSpecies()
		speciesInfo = cast Json.parse(AssetPaths.getTextFromFile('data/species/pokemon/${(Player.characterSpecies == null ? 'placeholder' : Player.characterSpecies)}.json'));
}
