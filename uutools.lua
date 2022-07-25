local CTM={}
CTM.frame = CreateFrame("Frame","uutools", UIParent)
CTM.frame:RegisterEvent("TRADE_SHOW")


CTM.frame:RegisterEvent("MAIL_SHOW")
CTM.frame:RegisterEvent("MAIL_CLOSED")



CTM.frame:RegisterEvent("BANKFRAME_OPENED")
CTM.frame:RegisterEvent("BANKFRAME_CLOSED")



CTM.frame:SetScript("OnEvent", function(self, event, ...)
	return CTM[event] and CTM[event](CTM, event, ...)
end)


function CTM:TRADE_SHOW(...)
    local name = GetUnitName("NPC");
    local level = UnitLevel("NPC");

    if  UnitInParty("NPC") then
        print("悠悠卫士检测到目标是队友,放行本次交易")
    else
        if level ==1 then
            print("悠悠卫士帮你阻止了一次欺诈交易.欺诈者是:"..name)
            CloseTrade();
            -- -- 允许交易的时刻，收到 1级 请求时,关闭包裹。
            -- local   blockTrades =   GetCVar("blockTrades")
            -- if blockTrades =='0' then
            --     CloseAllBags();
            -- end
            
        end
    end
end


function CTM:MAIL_SHOW(...)
    SetCVar("blockTrades",1)
    print("打开邮箱期间,悠悠卫士阻止交易")
end


function CTM:MAIL_CLOSED(...)
    SetCVar("blockTrades",0)
    print("悠悠卫士恢复交易")
end

function CTM:BANKFRAME_OPENED(...)
    SetCVar("blockTrades",1)
    print("打开银行期间,悠悠卫士阻止交易")
end


function CTM:BANKFRAME_CLOSED(...)
    SetCVar("blockTrades",0)
    print("悠悠卫士恢复交易")
end

