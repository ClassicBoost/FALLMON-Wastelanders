package fallmon.backend;

import fallmon.*;
import fallmon.backend.*;
import fallmon.states.menus.*;
import flixel.FlxGame;

class Main extends Sprite
{
	var game = {
		width: 800, // WINDOW width
		height: 600, // WINDOW height
		initialState: Init, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	public static var fpsVar:FPS;
	public static var mainClassState:Class<FlxState> = Init;

	public static var gameVersion:String = null;

	public static var fpsCounter:FPS;

	// If you don't want the players to cheat or some shit turn these off.
	public static var devMode:Bool = true;

	public function new()
	{
		super();

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		#end

		gameVersion = 'ALPHA TEST v0.1';

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}

		// here we set up the base game
		var gameCreate:FlxGame;
		gameCreate = new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate,
			game.skipSplash, game.startFullscreen);
		addChild(gameCreate); // and create it afterwards

		#if !mobile
		fpsCounter = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsCounter);
		#end
	}

	public static function framerateAdjust(input:Float)
	{
		return input * (60 / FlxG.drawFramerate);
	}

	public static var lastState:FlxState;

	public static function switchState(curState:FlxState, target:FlxState)
	{
		mainClassState = Type.getClass(target);

		FlxG.switchState(target);
		return trace('changed state');
	}

	public static function updateFramerate(newFramerate:Int)
	{
		// flixel will literally throw errors at me if I dont separate the orders
		if (newFramerate > FlxG.updateFramerate)
		{
			FlxG.updateFramerate = newFramerate;
			FlxG.drawFramerate = newFramerate;
		}
		else
		{
			FlxG.drawFramerate = newFramerate;
			FlxG.updateFramerate = newFramerate;
		}
	}
}
