class StyleRule
  @init: ->
    @styleNode        = @_buildStyleNode()
    @style            = @styleNode[if @styleNode.sheet then 'sheet' else 'styleSheet']
    @cssRulesProperty = if @style.rules      then "rules"      else "cssRules"
    @removeMethodName = if @style.removeRule then "removeRule" else "deleteRule"
    @insertRuleMethod = if @style.insertRule then @_insertRule else @_addRule
        
  @_buildStyleNode: ->    
    styleNode       = document.createElement "style"
    styleNode.type  = "text/css"
    styleNode.rel   = "alternate stylesheet"
    head = document.head or document.getElementsByTagName("head")[0] or document.documentElement
    head.appendChild styleNode
        
  @_addRule: (selector, declaration, index) ->
    index = index or @getCssRules().length
    @style.addRule selector, declaration, index
    index
        
  @_insertRule: (selector, declaration, index) ->
    index = index or @getCssRules().length
    @style.insertRule "#{selector} { #{declaration} }", index
    index
        
  @getCssRules: ->
    @init() if not @style?
    @style[@cssRulesProperty]
                
  @add: (selector, declaration, index) ->
    @init() if not @style?
    @insertRuleMethod.call @, selector, declaration, index
          
  @remove: (index) ->
    @init() if not @style?
    index = index or @getCssRules().length - 1
    @style[@removeMethodName].call @style, index
        
  @replace: (index, selector, declaration) ->
    @init() if not @style?
    @style[@removeMethodName].call @style, index
    @add selector, declaration, index

@StyleRule = StyleRule