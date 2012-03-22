#StyleRule

  StyleRule adds the ability to manage css style rules with javascript.

##Example

    var index_red     = StyleRule.add("body", "background: red;");
    var index_yellow  = StyleRule.add("body", "background: yellow;");
    var index_blue    = StyleRule.add("body", "background: blue;");
    var index_brown   = StyleRule.add("body", "background: brown;");
        
    StyleRule.replace(index_blue, "body", "background: violet;");
    StyleRule.remove(index_yellow);    