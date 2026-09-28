package utils;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class AssetManager {
    // Retorna o caminho completo de uma imagem comum (autocompleta assets/images/ e .png)
    public static function image(path:String):String {
        var fullPath:String = path;
        
        if (!StringTools.startsWith(fullPath, "assets/")) {
            fullPath = "assets/images/" + fullPath;
        }
        
        if (!StringTools.endsWith(fullPath, ".png")) {
            fullPath += ".png";
        }
        
        return fullPath;
    }

    // Carrega um FlxSprite com imagem simples já posicionada
    public static function loadGraphic(x:Float = 0, y:Float = 0, imagePath:String):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y);
        sprite.loadGraphic(image(imagePath));
        return sprite;
    }

    // Carrega um FlxSprite animado via Spritesheet (PNG + XML do Sparrow)
    // Autocompleta assets/images/, .png e .xml automaticamente
    public static function loadAnimatedSprite(
        x:Float = 0, 
        y:Float = 0, 
        name:String, 
        animName:String, 
        prefix:String, 
        fps:Int = 24, 
        loop:Bool = true
    ):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y);
        
        var pngPath:String = image(name);
        var xmlPath:String = StringTools.replace(pngPath, ".png", ".xml");
        
        sprite.frames = FlxAtlasFrames.fromSparrow(pngPath, xmlPath);
        sprite.animation.addByPrefix(animName, prefix, fps, loop);
        sprite.animation.play(animName);
        
        return sprite;
    }
}
