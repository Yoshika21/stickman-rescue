package utils;

import flixel.FlxG;

class SoundManager {
    public static function playMenuMusic():Void {
        FlxG.sound.playMusic(Constants.MUSIC_MENU, 0.7, true);
    }

    public static function playScroll():Void {
        FlxG.sound.play(Constants.SFX_SCROLL, 0.6);
    }

    public static function playConfirm():Void {
        FlxG.sound.play(Constants.SFX_CONFIRM, 0.8);
    }

    // Toca qualquer efeito sonoro preenchendo o caminho "assets/sounds/" automaticamente
    public static function playSound(soundName:String, volume:Float = 1.0):Void {
        var path:String = soundName;
        
        if (!StringTools.startsWith(path, "assets/")) {
            path = "assets/sounds/" + path;
        }
        
        if (!StringTools.endsWith(path, ".wav") && !StringTools.endsWith(path, ".ogg")) {
            path += ".wav";
        }

        FlxG.sound.play(path, volume);
    }

    // Toca qualquer música preenchendo o caminho "assets/music/" automaticamente
    public static function playMusic(musicName:String, volume:Float = 1.0, looped:Bool = true):Void {
        var path:String = musicName;
        
        if (!StringTools.startsWith(path, "assets/")) {
            path = "assets/music/" + path;
        }
        
        if (!StringTools.endsWith(path, ".wav") && !StringTools.endsWith(path, ".ogg")) {
            path += ".wav";
        }

        FlxG.sound.playMusic(path, volume, looped);
    }
}
