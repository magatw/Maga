-- ===========================================================================
-- file: UIC/Image
-- author: Hardballer
--
-- Image UIC Class
-- ===========================================================================

--# assume global class M_Image

local Console = require("Core/Console");
local Util = require("UIC/Util");
local Image = {} --# assume Image: M_Image


--v function(name: string, parent: CA_UIC) --> M_Image
function Image.new(name, parent) 
    local root = cm:ui_root();
    root:CreateComponent("MagaTemp", "ui/bin/image/"..name);
    local temp = UIComponent(root:Find("MagaTemp"));
    local image = UIComponent(temp:Find("flag_2"));

    parent:Adopt(image:Address());
    Util.delete(temp);

    local self = {};

    setmetatable(self, {
        __index = Image,
        __tostring = function() return "MAGA IMAGE: "..name end
    })

    --# assume self: M_Image

    self.uic = function(self) --: M_Image
        return image;
    end

    Console.log("Create Image: "..name, "UIC");

    return self;
end


--v function(self: M_Image, x: number, y: number)
function Image.MoveTo(self, x, y)
    self:uic():MoveTo(x, y);
end

--v function(self: M_Image, w: number, h: number)
function Image.Resize(self, w, h)
    self:uic():Resize(w, h);
end

--v function(self: M_Image, opacity: number)
function Image.SetOpacity(self, opacity)
    self:uic():SetOpacity(opacity);
end

--v function(self: M_Image, visible: boolean)
function Image.SetVisible(self, visible) 
    self:uic():SetVisible(visible);
end


--v function(self: M_Image, e: UIC_EventName, cb: function())
function Image.On(self, e, cb) 
    Util.on(self:uic(), e, cb);
end

--v function(self: M_Image)
function Image.Delete(self) 
    Util.delete(self:uic(), true);
end


return {
    new = Image.new;
}
