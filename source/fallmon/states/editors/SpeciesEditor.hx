package fallmon.states.editors;

import fallmon.gameObjects.Player;
import fallmon.gameObjects.userInterface.icons.ProtraitsIcon;

class SpeciesEditor extends FlxState
{
	public var player:Player;

	var nameSpeciesShit:FlxInputText;
	var typingShit:FlxInputText;
	var protraitName:FlxInputText;

	var UI_box:FlxUITabMenu;

	public var le_protrait:ProtraitsIcon;

	override function create()
	{
		super.create();

		le_protrait = new ProtraitsIcon('unown', true);
		le_protrait.y = 480;
		le_protrait.x = 190;
		le_protrait.antialiasing = Init.globalAnti;
		add(le_protrait);

		var tabs = [
			{name: "Main", label: 'Main'},
			{name: "Special", label: "Modifiers"},
			{name: "Settings", label: "Settings"}
		];

		UI_box = new FlxUITabMenu(null, tabs, true);

		UI_box.resize(400, 400);
		UI_box.x = FlxG.width / 2;
		UI_box.y = 100;
		add(UI_box);

		addUI();
		addSTATSUI();
		addSettingsUI();
	}

	var speciesNameShit:FlxUIInputText;
	var daTypeLol:FlxUIInputText;
	var protraitIg:FlxUIInputText;

	function addUI():Void
	{
		speciesNameShit = new FlxUIInputText(10, 20, 150, 'name', 8);
		nameSpeciesShit = speciesNameShit;

		daTypeLol = new FlxUIInputText(10, 50, 150, '', 8);
		typingShit = daTypeLol;

		protraitIg = new FlxUIInputText(10, 80, 150, 'unown', 8);
		protraitName = protraitIg;

		var tab_group_main = new FlxUI(null, UI_box);
		tab_group_main.name = "Main";
		tab_group_main.add(new FlxText(10, 5, 0, 'Species Name'));
		tab_group_main.add(new FlxText(10, 35, 0, 'Type'));
		tab_group_main.add(new FlxText(10, 65, 0, 'Protrait'));
		tab_group_main.add(speciesNameShit);
		tab_group_main.add(daTypeLol);
		tab_group_main.add(protraitIg);

		UI_box.addGroup(tab_group_main);
	}

	var strengthNUM:FlxUINumericStepper;
	var perceptionNUM:FlxUINumericStepper;
	var enduranceNUM:FlxUINumericStepper;
	var charismaNUM:FlxUINumericStepper;
	var intelligenceNUM:FlxUINumericStepper;
	var agilityNUM:FlxUINumericStepper;
	var luckNUM:FlxUINumericStepper;

	function addSTATSUI():Void
	{
		var tab_group_section = new FlxUI(null, UI_box);
		tab_group_section.name = 'Special';

		strengthNUM = new FlxUINumericStepper(10, 20, 1, 1, -9, 10, 1);
		strengthNUM.value = 0;
		strengthNUM.name = 'Strength';

		perceptionNUM = new FlxUINumericStepper(10, 50, 1, 1, -9, 10, 1);
		perceptionNUM.value = 0;
		perceptionNUM.name = 'Perception';

		enduranceNUM = new FlxUINumericStepper(10, 80, 1, 1, -9, 10, 1);
		enduranceNUM.value = 0;
		enduranceNUM.name = 'Endurance';

		charismaNUM = new FlxUINumericStepper(10, 110, 1, 1, -9, 10, 1);
		charismaNUM.value = 0;
		charismaNUM.name = 'Charisma';

		intelligenceNUM = new FlxUINumericStepper(10, 140, 1, 1, -9, 10, 1);
		intelligenceNUM.value = 0;
		intelligenceNUM.name = 'Intelligence';

		agilityNUM = new FlxUINumericStepper(10, 170, 1, 1, -9, 10, 1);
		agilityNUM.value = 0;
		agilityNUM.name = 'Agility';

		luckNUM = new FlxUINumericStepper(10, 200, 1, 1, -9, 10, 1);
		luckNUM.value = 0;
		luckNUM.name = 'Luck';

		tab_group_section.add(new FlxText(10, 5, 0, 'Strength:'));
		tab_group_section.add(new FlxText(10, 35, 0, 'Perception:'));
		tab_group_section.add(new FlxText(10, 65, 0, 'Endurance:'));
		tab_group_section.add(new FlxText(10, 95, 0, 'Charisma:'));
		tab_group_section.add(new FlxText(10, 125, 0, 'Intelligence:'));
		tab_group_section.add(new FlxText(10, 155, 0, 'Agility:'));
		tab_group_section.add(new FlxText(10, 185, 0, 'Luck:'));
		tab_group_section.add(strengthNUM);
		tab_group_section.add(perceptionNUM);
		tab_group_section.add(enduranceNUM);
		tab_group_section.add(charismaNUM);
		tab_group_section.add(intelligenceNUM);
		tab_group_section.add(agilityNUM);
		tab_group_section.add(luckNUM);

		UI_box.addGroup(tab_group_section);
	}

	function addSettingsUI():Void
	{
		var tab_group_sett = new FlxUI(null, UI_box);
		tab_group_sett.name = 'Settings';

		var saveButton:FlxButton = new FlxButton(110, 8, "Save", function()
		{
			saveStuff();
		});

		tab_group_sett.add(saveButton);
		UI_box.addGroup(tab_group_sett);
	}

	function getEvent(id:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>)
	{
		if (id == FlxUICheckBox.CLICK_EVENT) {}
		else if (id == FlxUIInputText.CHANGE_EVENT && (sender is FlxUIInputText))
		{
			if (sender == protraitIg)
			{
				le_protrait.updateProtrait(protraitIg.text, true);
			}
		}
		else if (id == FlxUINumericStepper.CHANGE_EVENT && (sender is FlxUINumericStepper)) {}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var inputTexts:Array<FlxUIInputText> = [speciesNameShit, protraitIg, daTypeLol];
		for (i in 0...inputTexts.length)
		{
			if (inputTexts[i].hasFocus)
			{
				if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.V && Clipboard.text != null)
				{ // Copy paste
					inputTexts[i].text = ClipboardAdd(inputTexts[i].text);
					inputTexts[i].caretIndex = inputTexts[i].text.length;
					getEvent(FlxUIInputText.CHANGE_EVENT, inputTexts[i], null, []);
				}
				if (FlxG.keys.justPressed.ENTER)
				{
					inputTexts[i].hasFocus = false;
				}
				FlxG.sound.muteKeys = [];
				FlxG.sound.volumeDownKeys = [];
				FlxG.sound.volumeUpKeys = [];
				super.update(elapsed);
				return;
			}
		}

		if (FlxG.keys.justPressed.ESCAPE)
			Main.switchState(this, new MainMenuState());
	}

	var _file:FileReference;

	function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved file.");
	}

	/**
		* Called when the save file dialog is cancelled.
		*/
	function onSaveCancel(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	}

	/**
		* Called if there is an error while saving the gameplay recording.
		*/
	function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving file");
	}

	function saveStuff()
	{
		var json = {
			"type": typingShit,

			"str": strengthNUM.value,
			"per": perceptionNUM.value,
			"end": enduranceNUM.value,
			"cha": charismaNUM.value,
			"int": intelligenceNUM.value,
			"agl": agilityNUM.value,
			"luk": luckNUM.value,

			"hp": 0,
			"stamina": 0,
			"pp": 0,

			"ac": 0,
			"radresist": 0,

			"protrait": protraitName
		};

		var data:String = Json.stringify(json, "\t");

		if (data.length > 0)
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(data, nameSpeciesShit + ".json");
		}
	}

	function ClipboardAdd(prefix:String = ''):String
	{
		if (prefix.toLowerCase().endsWith('v')) // probably copy paste attempt
		{
			prefix = prefix.substring(0, prefix.length - 1);
		}

		var text:String = prefix + Clipboard.text.replace('\n', '');
		return text;
	}
}
