VERSION = "1.0.0"
-- This is a project made because the offical wakatime plugin for micro does not work

local micro = import("micro")
local config = import("micro/config")
local util = import("micro/util")
local shell = import("micro/shell")
-- golang
local filepath = import("filepath")
local http = import("http")
local ioutil = import("io/ioutil")
local os2 = import("os")
local runtime = import("runtime")

local lastFile = ""
local lastHeartbeat = 0


function init(bp)
    local config = shell.RunCommand("wakatime --config-read api_key")
    --micro.TermMessage(config)
    if  config ~= nil then else 
		micro.TermMessage("you do not have an API key \n please add your API key to your wakatime config at ~/.wakatime.cfg")
	end
    

end

function sendHeartbeat(file,isWrite,X,Y)
    micro.Log("sent saved heartbeat")
    if isWrite == true then
        micro.Log(shell.RunCommand("wakatime --entity " .. file .. " --write --plugin \"Micro Wakatime\"--cursorpos" .. X .. " --lineno "..Y  ) )
    else
        micro.Log(shell.RunCommand("wakatime --entity " .. file .. "--plugin \"Micro Wakatime\" --cursorpos" .. X .. " --lineno "..Y ) )
    end
    return false
end

function onEvent(file, isWrite, bp)
    local time = os.time()
    if isWrite or enoughTimePassed(time) or lastFile ~= file then
        sendHeartbeat(file, isWrite,bp.Cursor.Loc.X,bp.Cursor.Loc.Y)
        lastFile = file
        lastHeartbeat = time
    end
end

function onSave(bp)
    onEvent(bp.buf.AbsPath, true, bp)

    return true
end

function onSaveAll(bp)
    onEvent(bp.buf.AbsPath, true,bp)

    return true
end

function onSaveAs(bp)
    onEvent(bp.buf.AbsPath, true,bp)

    return true
end

function onOpenFile(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onPaste(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectAll(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onDeleteLine(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onCursorUp(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end
function onCursorDown(bp)

    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onCursorPageUp(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onCursorPageDown(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onCursorLeft(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onCursorRight(bp)
	--micro.TermMessage(bp.Cursor.Loc.X)
	
    onEvent(bp.buf.AbsPath, false,bp)
	
    return true
end

function onCursorStart(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onCursorEnd(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectToStart(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectToEnd(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectUp(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectDown(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectLeft(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectRight(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectToStartOfText(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectToStartOfTextToggle(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onWordRight(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onWordLeft(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectWordRight(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onSelectWordLeft(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onMoveLinesUp(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onMoveLinesDown(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onScrollUp(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function onScrollDown(bp)
    onEvent(bp.buf.AbsPath, false,bp)

    return true
end

function enoughTimePassed(time)
    return lastHeartbeat + 120000 < time
end

