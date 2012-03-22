(function() {
  var StyleRule;

  StyleRule = (function() {

    function StyleRule() {}

    StyleRule.init = function() {
      this.styleNode = this._buildStyleNode();
      this.style = this.styleNode[this.styleNode.sheet ? 'sheet' : 'styleSheet'];
      this.cssRulesProperty = this.style.rules ? "rules" : "cssRules";
      this.removeMethodName = this.style.removeRule ? "removeRule" : "deleteRule";
      return this.insertRuleMethod = this.style.insertRule ? this._insertRule : this._addRule;
    };

    StyleRule._buildStyleNode = function() {
      var head, styleNode;
      styleNode = document.createElement("style");
      styleNode.type = "text/css";
      styleNode.rel = "alternate stylesheet";
      head = document.head || document.getElementsByTagName("head")[0] || document.documentElement;
      return head.appendChild(styleNode);
    };

    StyleRule._addRule = function(selector, declaration, index) {
      index = index || this.getCssRules().length;
      this.style.addRule(selector, declaration, index);
      return index;
    };

    StyleRule._insertRule = function(selector, declaration, index) {
      index = index || this.getCssRules().length;
      this.style.insertRule("" + selector + " { " + declaration + " }", index);
      return index;
    };

    StyleRule.getCssRules = function() {
      if (!(this.style != null)) this.init();
      return this.style[this.cssRulesProperty];
    };

    StyleRule.add = function(selector, declaration, index) {
      if (!(this.style != null)) this.init();
      return this.insertRuleMethod.call(this, selector, declaration, index);
    };

    StyleRule.remove = function(index) {
      if (!(this.style != null)) this.init();
      index = index || this.getCssRules().length - 1;
      return this.style[this.removeMethodName].call(this.style, index);
    };

    StyleRule.replace = function(index, selector, declaration) {
      if (!(this.style != null)) this.init();
      this.style[this.removeMethodName].call(this.style, index);
      return this.add(selector, declaration, index);
    };

    return StyleRule;

  })();

  this.StyleRule = StyleRule;

}).call(this);
