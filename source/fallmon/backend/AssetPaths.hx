package fallmon.backend;

#if sys
import sys.FileSystem;
#end

class AssetPaths
{
	static final audioExtension:String = "ogg";

	// stealing my own code from psych engine
	public static var currentTrackedAssets:Map<String, FlxGraphic> = [];
	public static var currentTrackedTextures:Map<String, Texture> = [];
	public static var currentTrackedSounds:Map<String, Sound> = [];

	// define the locally tracked assets
	public static var localTrackedAssets:Array<String> = [];

	inline static public function file(key:String, location:String, extension:String):String
	{
		var data:String = 'assets/$location/$key.$extension';
		/*#if override
			if(FileSystem.exists('override/$location/$key.$extension')){
				data = 'override/$location/$key.$extension';
				//trace("OVERRIDE FOR " + key + " FOUND!");
			}
			#end */
		return data;
	}

	inline public static function getPath(file:String, type:AssetType, ?library:Null<String>)
	{
		/*
				Okay so, from what I understand, this loads in the current path based on the level
				we're in (if a library is not specified), say like week 1 or something, 
				then checks if the assets you're looking for are there.
				if not, it checks the shared assets folder.
			// */

		// well I'm rewriting it so that the library is the path and it looks for the file type
		// later lmao I don't really wanna rn

		if (library != null)
			return getLibraryPath(file, library);

		var levelPath = getLibraryPathForce(file, "mods");
		if (OpenFlAssets.exists(levelPath, type))
			return levelPath;

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		var returnPath:String = 'assets/$file';
		return returnPath;
	}

	inline static public function image(key:String, ?library:String, ?textureCompression:Bool = false)
	{
		var returnAsset:FlxGraphic = returnGraphic(key, library, textureCompression);
		return returnAsset;
	}

	inline static public function xml(key:String, ?location:String = "images")
	{
		return file(key, location, "xml");
	}

	inline static public function text(key:String, ?location:String = "data")
	{
		return file(key, location, "txt");
	}

	inline static public function json(key:String, ?location:String = "data")
	{
		return file(key, location, "json");
	}

	inline static public function sound(key:String)
	{
		return file(key, "sounds", audioExtension);
	}

	inline static public function music(key:String)
	{
		return file(key, "music", audioExtension);
	}

	inline static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), xml(key));
	}

	inline static public function getPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), text(key, "images"));
	}

	inline static public function video(key:String)
	{
		return file(key, "videos", "mp4");
	}

	inline static public function font(key:String, ?extension:String = "ttf")
	{
		return file(key, "fonts", extension);
	}

	/*
	 * Uses FileSystem.exists for desktop and Assets.exists for non-desktop builds.
	 * This is because Assets.exists just checks the manifest and can't find files that weren't compiled with the game.
	 * This also means that if you delete a file, it will return true because it's still in the manifest.
	 * FileSystem only works on certain build types though (namely, not web).
	 */
	public static function exists(path:String):Bool
	{
		#if desktop
		return FileSystem.exists(path);
		#else
		return Assets.exists(path);
		#end
	}

	public static function returnGraphic(key:String, ?library:String, ?textureCompression:Bool = false)
	{
		var path = getPath('images/$key.png', IMAGE, library);
		#if sys
		if (FileSystem.exists(path))
		{
			if (!currentTrackedAssets.exists(key))
			{
				var bitmap = BitmapData.fromFile(path);
				var newGraphic:FlxGraphic;
				if (textureCompression)
				{
					var texture = FlxG.stage.context3D.createTexture(bitmap.width, bitmap.height, BGRA, true, 0);
					texture.uploadFromBitmapData(bitmap);
					currentTrackedTextures.set(key, texture);
					bitmap.dispose();
					bitmap.disposeImage();
					bitmap = null;
					trace('new texture $key, bitmap is $bitmap');
					newGraphic = FlxGraphic.fromBitmapData(BitmapData.fromTexture(texture), false, key, false);
				}
				else
				{
					newGraphic = FlxGraphic.fromBitmapData(bitmap, false, key, false);
					trace('new bitmap $key, not textured');
				}
				currentTrackedAssets.set(key, newGraphic);
			}
			localTrackedAssets.push(key);
			return currentTrackedAssets.get(key);
		}
		#end
		trace('oh no ' + key + ' is returning null NOOOO');
		return null;
	}
}
