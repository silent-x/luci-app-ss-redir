require("luci.sys")

local UCI  = (require "luci.model.uci").cursor()

local apply = luci.http.formvalue("cbi.apply")               
if apply then                                                
        luci.sys.exec("/usr/ss-redir-ip.sh")       -- reload configuration
end 

local s = luci.sys.exec('iptables --list PREROUTING --table nat -n'):gsub("\n","<p>")
m = Map("ss-redir-ip", translate("SS-redir"), s)

redirection=m:section(TypedSection, "redirection", translate("Redirections"))
redirection.template = "cbi/tblsection"
redirection.anonymous = false
redirection.addremove = true

ena=redirection:option(Flag, "enabled", translate("Enabled"))
ena.rmempty = false

hostip=redirection:option(Value, "hostip", translate("Host IP"))
hostip.rmempty = false

protocol=redirection:option(Value, "protocol", translate("Protocol"))
protocol.rmempty = false

matchipset=redirection:option(Flag, "matchipset", translate("Is Match"))
matchipset.rmempty = false

ipsetname=redirection:option(Value, "ipsetname", translate("IP Set"))
ipsetname.rmempty = false

toport=redirection:option(Value, "toport", translate("To Port"))
toport.rmempty = false

return m

