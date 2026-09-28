package utils;

#if DISCORD_ALLOWED
import hxdiscord_rpc.DiscordRpc;
import hxdiscord_rpc.Types;
#end

class DiscordRPCUtil {
    // Insira seu Client ID do painel de desenvolvedor do Discord aqui
    public static var clientID:String = ""; 
    private static var isInitialized:Bool = false;

    // Detalhes e Estado atuais editáveis dinamicamente
    public static var currentDetails:String = "In the main menu";
    public static var currentState:String = "Gettin ready";

    public static function init():Void {
        #if DISCORD_ALLOWED
        if (isInitialized || clientID == null || clientID == "1554117502173450301") return;

        var handlers = new DiscordEventHandlers();
        handlers.ready = cpp.Function.fromStatic(onReady);
        handlers.disconnected = cpp.Function.fromStatic(onDisconnected);
        handlers.errored = cpp.Function.fromStatic(onError);

        DiscordRpc.start(new DiscordRpcParams({
            clientID: clientID,
            eventHandlers: handlers
        }));

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

        var presence = new DiscordRichPresence();
        presence.details = currentDetails;
        presence.state = currentState;
        presence.largeImageKey = largeImageKey;
        presence.largeImageText = largeImageText;
        presence.smallImageKey = smallImageKey;
        presence.smallImageText = smallImageText;
        presence.startTimestamp = cast(Date.now().getTime() / 1000, Int);

        DiscordRpc.updatePresence(presence);
        #end
    }

    public static function update():Void {
        #if DISCORD_ALLOWED
        if (isInitialized) {
            DiscordRpc.runCallbacks();
        }
        #end
    }

    public static function shutdown():Void {
        #if DISCORD_ALLOWED
        if (isInitialized) {
            DiscordRpc.shutdown();
            isInitialized = false;
        }
        #end
    }

    #if DISCORD_ALLOWED
    private static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void {}
    private static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void {}
    private static function onError(errorCode:Int, message:cpp.ConstCharStar):Void {}
    #end
}
