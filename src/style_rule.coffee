class StyleRule
  constructor: ->
    @styleNode        = @_buildStyleNode()
    @style            = @styleNode[if @styleNode.sheet then 'sheet' else 'styleSheet']
    @cssRulesProperty = if @style.rules      then "rules"      else "cssRules"
    @removeMethodName = if @style.removeRule then "removeRule" else "deleteRule"
    @insertRuleMethod = if @style.insertRule then @_insertRule else @_addRule
        
  _buildStyleNode: ->    
    styleNode       = document.createElement "style"
    styleNode.type  = "text/css"
    styleNode.rel   = "alternate stylesheet"
    head = document.head or document.getElementsByTagName("head")[0] or document.documentElement
    head.appendChild styleNode
        
  _addRule: (selector, declaration, index) ->
    index = index or @getCssRules().length
    @style.addRule selector, declaration, index
    index
        
  _insertRule: (selector, declaration, index) ->
    index = index or @getCssRules().length
    @style.insertRule "#{selector} { #{declaration} }", index
    index
        
  getCssRules: ->
    @style[@cssRulesProperty]
                
  add: (selector, declaration, index) ->
    @insertRuleMethod.call @, selector, declaration, index
          
  remove: (index) ->
    index = index or @getCssRules().length - 1
    @style[@removeMethodName].call @style, index
        
  replace: (index, selector, declaration) ->
    @style[@removeMethodName].call @style, index
    @add selector, declaration, index

@StyleRule = StyleRule