###
Implements many common graphical functionalities of UltimateLib, allows easy conversion from UltimateLib
###
SDP.Graphical = ((s) ->

	s.Elements = ((e) ->
		e.Head = $("head")
		e.Body = $("body")
		e.SettingsPanel = $("#settingsPanel")
		e.GameContainerWrapper = $("#gameContainerWrapper")
		e.SimpleModalContainer = $("#simplemodal-container")
		e
	)(s.Elements or {})

	s.Visuals = ((v) ->
		v.Custom = ((c) ->
			vis = "SDP-Visuals-Custom"
			c.setCss = (id, content) ->
				id = vis+id
				$("head").append('<style id="#{e}" type="text/css"></style>') if $("##{id}").length is 0
				$("head").find("##{id}").append(content)

			c.addCss = (id, content) ->
				id = vis+id;
				$("head").append('<style id="#{e}" type="text/css"></style>') if $("##{id}").length is 0
				$("head").find("##{id}").html(content);
			c
		)(v.Custom or {})

		v
	)(s.Visuals or {})

	panelChildren = s.Elements.SettingsPanel.children()
	div = $ document.createElement("div")
	div.attr("id", "SDPConfigurationTabs")
	div.css { width: "100%", height: "auto"}
	sdpElement = $ document.createElement("sdp")
	sdpElement.attr("id", "SDPConfigurationTabsList")
	sdpElement.append('<li><a href="#SDPConfigurationDefaultTabPanel">Game</a></li>')
	div2 = $(document.createElement("div"))
	div2.attr("id", "SDPConfigurationDefaultTabPanel")
	sdpElement.appendTo(div)
	div2.appendTo(div)
	panelChildren.appendTo(div.find("#SDPConfigurationDefaultTabPanel").first())
	div.appendTo(UltimateLib.Elements.SettingsPanel)
	div.tabs()
	div.find(".ui-tabs .ui-tabs-nav li a").css { fontSize: "7pt" }
	UltimateLib.Visuals.Custom.setCss("advanceOptionsCss", "#newGameView .featureSelectionPanel { overflow-x: none overflow-y: auto }</style>")
	UltimateLib.Visuals.Custom.setCss("settingPanelCss", ".ui-dialog .ui-dialog-content { padding: .5em 1em 1em .5em overflow-x: none overflow-y: visible }")

	a.setLayoutCss = (modName) ->
		b = $ 'link[href$="layout.css"]'
		b.attr("href", ".mods/#{modName}/css/layout.css")

	s.addTab = (tabId, category, content) ->
		div = $ document.createElement("div")
		div.attr { id: tabId }
		div.css {width: "100%", height: "auto", display: "block"}
		div2 = $ document.createElement("div")
		div2.attr "id", "#{tabId}Container"
		div.append(div2)
		div2.append(content)
		configTabs = $ "SDPConfigurationTabs"
		configTabs.tabs("add", "##{tabId}", category)
		configTabs.tabs("refresh")
		configTabs.tabs("select", 0)
		$("##{tabId}").append(b)
		div

	s.addAdvancedOption = (content) ->
		selection = $("#newGameView").find(".featureSelectionPanel.featureSelectionPanelHiddenState")
		selection.append(content)

	s
)(SDP.Graphical or {})

