// Generated by CoffeeScript 1.10.0

/*
Implements many common graphical functionalities of UltimateLib, allows easy conversion from UltimateLib
 */

(function() {
  SDP.Graphical = (function(s) {
    var div, div2, panelChildren, sdpElement;
    s.Elements = (function(e) {
      e.Head = $("head");
      e.Body = $("body");
      e.SettingsPanel = $("#settingsPanel");
      e.GameContainerWrapper = $("#gameContainerWrapper");
      e.SimpleModalContainer = $("#simplemodal-container");
      return e;
    })(s.Elements || {});
    s.Visuals = (function(v) {
      v.Custom = (function(c) {
        var vis;
        vis = "SDP-Visuals-Custom";
        c.setCss = function(id, content) {
          id = vis + id;
          if ($("#" + id).length === 0) {
            $("head").append('<style id="#{e}" type="text/css"></style>');
          }
          return $("head").find("#" + id).append(content);
        };
        c.addCss = function(id, content) {
          id = vis + id;
          if ($("#" + id).length === 0) {
            $("head").append('<style id="#{e}" type="text/css"></style>');
          }
          return $("head").find("#" + id).html(content);
        };
        return c;
      })(v.Custom || {});
      return v;
    })(s.Visuals || {});
    panelChildren = s.Elements.SettingsPanel.children();
    div = $(document.createElement("div"));
    div.attr("id", "SDPConfigurationTabs");
    div.css({
      width: "100%",
      height: "auto"
    });
    sdpElement = $(document.createElement("sdp"));
    sdpElement.attr("id", "SDPConfigurationTabsList");
    sdpElement.append('<li><a href="#SDPConfigurationDefaultTabPanel">Game</a></li>');
    div2 = $(document.createElement("div"));
    div2.attr("id", "SDPConfigurationDefaultTabPanel");
    sdpElement.appendTo(div);
    div2.appendTo(div);
    panelChildren.appendTo(div.find("#SDPConfigurationDefaultTabPanel").first());
    div.appendTo(UltimateLib.Elements.SettingsPanel);
    div.tabs();
    div.find(".ui-tabs .ui-tabs-nav li a").css({
      fontSize: "7pt"
    });
    UltimateLib.Visuals.Custom.setCss("advanceOptionsCss", "#newGameView .featureSelectionPanel { overflow-x: none overflow-y: auto }</style>");
    UltimateLib.Visuals.Custom.setCss("settingPanelCss", ".ui-dialog .ui-dialog-content { padding: .5em 1em 1em .5em overflow-x: none overflow-y: visible }");
    a.setLayoutCss = function(modName) {
      var b;
      b = $('link[href$="layout.css"]');
      return b.attr("href", ".mods/" + modName + "/css/layout.css");
    };
    s.addTab = function(tabId, category, content) {
      var configTabs;
      div = $(document.createElement("div"));
      div.attr({
        id: tabId
      });
      div.css({
        width: "100%",
        height: "auto",
        display: "block"
      });
      div2 = $(document.createElement("div"));
      div2.attr("id", tabId + "Container");
      div.append(div2);
      div2.append(content);
      configTabs = $("SDPConfigurationTabs");
      configTabs.tabs("add", "#" + tabId, category);
      configTabs.tabs("refresh");
      configTabs.tabs("select", 0);
      $("#" + tabId).append(b);
      return div;
    };
    s.addAdvancedOption = function(content) {
      var selection;
      selection = $("#newGameView").find(".featureSelectionPanel.featureSelectionPanelHiddenState");
      return selection.append(content);
    };
    return s;
  })(SDP.Graphical || {});

}).call(this);