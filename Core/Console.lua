-- ===========================================================================
-- file: Core/Console
-- author: Hardballer
--
-- Pseudo console that outputs to maga_log.txt
-- ===========================================================================

local Console = {};

Console.enableLog = false;
Console.consoleMode = true;

Console.lines = {} --: vector<string>
Console.maxLines = 40;
Console.filePath = "data/maga_log.txt";

--v function(str: string)
function Console.write(str)
    if Console.consoleMode then
        if #Console.lines > Console.maxLines then 
            table.remove(Console.lines, 1);
        end
        
        table.insert(Console.lines, str);

        local file = io.open(Console.filePath,"w+");
        for index, line in ipairs(Console.lines) do 
            file:write(line.."\n");
        end
        
        file:close();
    else
        local file = io.open(Console.filePath,"a+");
        file:write(str.."\n");
        file:close();
    end
end

--v function(arg: any, logType: string)
function Console.log(arg, logType) 
    if not Console.enableLog then return end

    local time = os.date("%H:%M.%S");
    --# assume time: string

    local str = "["..time.."] "..logType.." > "..tostring(arg);
    Console.write(str);
end

--v function(arg: any)
function Console.print(arg)
    local str --: string
    
    if is_uicomponent(arg) then
        --# assume arg: CA_UIC
        str = uicomponent_to_str(arg);
    else
        str = tostring(arg);
    end

    Console.write(str);
end

--v function(t: any)
function Console.printTable(t)
    if type(t) ~= "table" then return Console.print(t) end
    --# assume t: map<number | string, any>

    Console.write("\n###### "..tostring(t).." ######");
    
    for k, v in pairs(t) do
        Console.write("\t"..k.." => "..tostring(v));
    end
    
    Console.write("###### "..tostring(t).." ######\n");
end


return {
    log = Console.log;
    print = Console.print;
    printTable = Console.printTable;
}
