package utils;

#if DISCORD_ALLOWED
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;
#end

class DiscordRPCUtil {
    public static var clientID:String = "1554117502173450301";
    private static var isInitialized:Bool = false;

    public static var currentDetails:String = "In the main menu";
    public static var currentState:String = "Gettin ready";

    public static function init():Void {
        #if DISCORD_ALLOWED
        if (isInitialized || clientID == null || clientID == "") return;

        var handlers:DiscordEventHandlers = new DiscordEventHandlers();
        handlers.ready = cpp.Function.fromStaticFunction(onReady);
        handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
        handlers.errored = cpp.Function.fromStaticFunction(onError);

        Discord.Initialize(clientID, cpp.RawPointer.addressOf(handlers), false, null);

        isInitialized = true;
        changePresence(currentDetails, currentState);
        #end
    }

    public static function changePresence(
        ?details:String,
        ?state:String,
        ?largeImageKey:String = "stickman_defaultL",
        ?largeImageText:String = "Stickman Rescue",
        ?smallImageKey:String = "stickman_default",
        ?smallImageText:String = "Stickman"
    ):Void {
        #if DISCORD_ALLOWED
        if (!isInitialized) return;

        if (details != null) currentDetails = details;
        if (state != null) currentState = state;

        var discordPresence:DiscordRichPresence = new DiscordRichPresence();
        discordPresence.details = currentDetails;
        discordPresence.state = currentState;
        discordPresence.largeImageKey = largeImageKey;
        discordPresence.largeImageText = largeImageText;
        discordPresence.smallImageKey = smallImageKey;
        discordPresence.smallImageText = smallImageText;

        Discord.UpdatePresence(cpp.RawConstPointer.addressOf(discordPresence));
        #end
    }

    public static function update():Void {
        #if DISCORD_ALLOWED
        if (isInitialized) {
            Discord.RunCallbacks();
        }
        #end
    }

    public static function shutdown():Void {
        #if DISCORD_ALLOWED
        if (isInitialized) {
            Discord.Shutdown();
            isInitialized = false;
        }
        #end
    }

    #if DISCORD_ALLOWED
    private static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void {
        // Discord conectado
    }

    private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void {
        // Tratamento de desconexão
    }

    private static function onError(errorCode:Int, message:cpp.ConstCharStar):Void {
        // Tratamento de erro
    }
    #end
}
