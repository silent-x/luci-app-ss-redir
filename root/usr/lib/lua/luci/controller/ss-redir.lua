module("luci.controller.ss-redir", package.seeall)

function index()
        entry({"admin", "network", "ss-redir"}, cbi("ss-redir"), _("SS-redir"), 100)
        end
