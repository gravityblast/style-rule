#StyleRule

  Cross-browser css style rules management from javascript.

##Example
    
    var styleRule    = new StyleRule();
    var index_red    = styleRule.add("body", "background: red;");
    var index_yellow = styleRule.add("body", "background: yellow;");
    var index_blue   = styleRule.add("body", "background: blue;");
    var index_brown  = styleRule.add("body", "background: brown;");
        
    styleRule.replace(index_blue, "body", "background: violet;");
    styleRule.remove(index_yellow);    