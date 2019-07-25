if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

" Dollar sign is permitted anywhere in an identifier
if (v:version > 704 || v:version == 704 && has('patch1142')) && main_syntax == 'javascript'
  syntax iskeyword @,48-57,_,192-255,$
else
  setlocal iskeyword+=$
endif

syntax sync fromstart
" TODO: Figure out what type of casing I need
" syntax case ignore
syntax case match


" Tokens
" IdenfierName
syntax match jsSemicolon +;+ display
syntax match jsComma +,+ display
syntax match jsColon +:+ skipwhite skipempty nextgroup=@jsExpression display
syntax match jsAssignmentEqual +=+ skipwhite skipempty nextgroup=@jsExpression display
syntax match jsDot +\.+ display
syntax match jsSpread +\.\.\.+ skipwhite skipempty nextgroup=@jsExpression display
syntax match jsParensError +[)}\]]+ display

" Operators
" REFERENCE: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators
syntax keyword jsUnaryOperator delete void typeof new skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsRelationalOperator in instanceof skipwhite skipempty nextgroup=@jsExpression

syntax match   jsOperatorArithmetic +\([+*-]\{1,2}\|[/%]\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorComparison +\([=!]==\?\|[<>]=\?\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorBit +\([&^|~]\|<<\|>>>\?\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorLogical +\(!\|[|&]\{2}\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorConditional +[?:]+ skipwhite skipempty nextgroup=@jsExpression display

" " *=/=%=+=-=<<=>>=>>>=&=^=|=**=
syntax match   jsOperatorAssignment +\([-/%+&|^]\|<<\|>>>\?\|\*\*\?\)=+ skipwhite skipempty nextgroup=@jsExpression display

syntax cluster jsOperators contains=jsRelationalOperator,jsOperator.*

" Modules
syntax keyword jsImport import skipwhite skipempty nextgroup=jsModuleName,jsModuleAsterisk,jsModuleBlock,jsString
syntax keyword jsExport export skipwhite skipempty nextgroup=jsVariableType,jsFunction,jsClass,jsModuleBlock,jsModuleDefault,jsModuleAsterisk
syntax keyword jsFrom from contained skipwhite skipempty nextgroup=jsString
syntax keyword jsModuleDefault default contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsModuleAsterisk +\*+ contained skipwhite skipempty nextgroup=jsModuleAs,jsFrom display
syntax keyword jsModuleAs as contained skipwhite skipempty nextgroup=jsModuleName
syntax region  jsModuleBlock matchgroup=jsModuleBrace start=+{+ end=+}+ contained contains=jsModuleName,jsModuleComma skipwhite skipempty nextgroup=jsFrom
syntax match   jsModuleName +\<\K\k*\>+ contained contains=jsModuleDefault skipwhite skipempty nextgroup=jsFrom,jsModuleComma,jsModuleAs display
syntax match   jsModuleComma +,+ contained skipwhite skipempty nextgroup=jsModuleBlock,jsModuleName,jsModuleAsterisk display

" Comments
" Comments can be treat as a special expression which produce nothing
syntax keyword jsCommentTodo contained TODO FIXME XXX TBD
syntax region  jsComment start=+//+ end=/$/ contains=jsCommentTodo,@Spell extend keepend
syntax region  jsComment start=+/\*+  end=+\*/+ contains=jsCommentTodo,@Spell extend fold
" syntax region  jsEnvComment start=/\%^#!/ end=/$/ display

" Declaration
syntax keyword jsVariableType const let var skipwhite skipempty nextgroup=jsVariable,jsObjectDestructuring,jsArrayDestructuring
syntax match   jsVariable +\<\K\k*\>+ contains=jsRelationalOperator skipwhite skipempty nextgroup=jsOperatorComparison,jsOperatorAssignment,jsAssignmentEqual,jsArrow,jsAccessor display

" Strings, Literals, Numbers
syntax region  jsString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsAccessor
syntax region  jsTemplateString start=+`+ skip=+\\`+ end=+`+ contains=jsTemplateExpression,@Spell extend skipwhite skipempty nextgroup=jsColon,jsAccessor
syntax region  jsTemplateExpression matchgroup=jsTemplateBrace start=+${+ end=+}+ contained contains=@jsExpression
syntax keyword jsValueKeyword undefined null NaN true false skipwhite skipempty nextgroup=jsAccessor
syntax match   jsNumber +\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>+ skipwhite skipempty nextgroup=jsAccessor display
syntax keyword jsNumber Infinity
syntax match   jsFloat +\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>+ skipwhite skipempty nextgroup=jsAccessor display

" Code block
syntax region  jsBlock matchgroup=jsBlockBrace start=+{+ end=+}+ contains=TOP extend fold
syntax region  jsParen matchgroup=jsParenBrace start=+(+ end=+)+ contains=@jsExpression,@jsOperators,jsComma,jsSpread extend fold skipwhite skipempty nextgroup=jsArrow,jsParen,jsAssignmentEqual,jsAccessor

" Array
syntax region  jsArray matchgroup=jsArrayBrace start=+\[+ end=+]+ contains=@jsExpression,@jsOperators,jsComma,jsSpread skipwhite skipempty nextgroup=jsAccessor

" Object
syntax region  jsObject matchgroup=jsObjectBrace start=+{+ end=+}+ contained contains=jsVariable,jsObjectKey,jsObjectKeyString,jsMethod,jsComputed,jsGeneratorAsterisk,jsAsync,jsGetter,jsSetter,jsComma,jsSpread,@jsOperators
syntax match   jsObjectKey +\<\K\k*\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsColon display
syntax match   jsObjectKey +\d\++ contained skipwhite skipempty nextgroup=jsColon display
syntax region  jsObjectKeyString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsColon

" Cases like obj["prop"]
syntax region  jsAccessor matchgroup=jsAccessorBrace start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallParen

" Array Destructuring
" Cases like [a, b] = [1, 2] and the array destructuring in the arrow function arguments cannot be highlighted
" as array destructuring, they are highlighted as Array, but it doesn't break the syntax
syntax region  jsArrayDestructuring matchgroup=jsDestructuringBrace start=+\[+ end=+]+ contained contains=jsVariable,jsComma,jsObjectDestructuring,jsArrayDestructuring,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual

" Object Destructuring
" Cases like ({a, b} = {a: 1, b: 2}) and the object destructuring in the arrow function arguments cannot be highlighted
" as object destructuring, they are highlighted as Object, but it doesn't break the syntax
syntax region  jsObjectDestructuring matchgroup=jsDestructuringBrace start=+{+ end=+}+ contained contains=jsObjectDestructuringKey,jsVariable,jsComma,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual
syntax match   jsObjectDestructuringKey +\<\K\k*\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsAssignmentEqual,jsObjectDestructuringColon display
syntax match   jsObjectDestructuringColon +:+ contained skipwhite skipempty nextgroup=jsVariable,jsObjectDestructuring,jsArrayDestructuring display

" Class
syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassName,jsClassBody
syntax keyword jsExtends extends contained skipwhite skipempty nextgroup=jsClassName
syntax keyword jsConstructor constructor contained
syntax keyword jsSuper super contained skipwhite skipempty nextgroup=jsAccessor
syntax keyword jsStatic static contained skipwhite skipempty nextgroup=jsClassProp,jsMethod
syntax match   jsClassName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsExtends,jsClassBody display
syntax region  jsClassBody matchgroup=jsClassBrace start=+{+ end=+}+ contained contains=jsAsync,jsStatic,jsSetter,jsGetter,jsClassProp,jsMethod,jsComment,jsGeneratorAsterisk,jsComputed extend fold
syntax match   jsClassProp +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsAssignmentEqual display

" Function
syntax keyword jsAsync async skipwhite skipempty nextgroup=jsFunction,jsFunctionArgs,jsGeneratorAsterisk,jsComputed
syntax keyword jsAwait await skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsThis this skipwhite skipempty nextgroup=jsAccessor
syntax keyword jsReturn return skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsFunction function skipwhite skipempty nextgroup=jsGeneratorAsterisk,jsFunctionName,jsFunctionArgs
syntax match   jsFunctionName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFunctionArgs display
syntax region  jsFunctionArgs matchgroup=jsFunctionArgsBrace start=+(+ end=+)+ contained contains=jsVariable,jsComma,jsSpread,jsObjectDestructuring,jsArrayDestructuring skipwhite skipempty nextgroup=jsArrow,jsFunctionBody extend fold
syntax region  jsFunctionBody matchgroup=jsFunctionBodyBrace start=+{+ end=+}+ contained contains=TOP extend fold

" Arrow Function
syntax match   jsArrow +=>+ contained skipwhite skipempty nextgroup=@jsExpression,jsFunctionBody display

" Object method
syntax match   jsMethod +\<\K\k*\>\(\_s*(\)\@=+ contains=jsConstructor skipwhite skipempty nextgroup=jsFunctionArgs display
syntax keyword jsGetter get contained skipwhite skipempty nextgroup=jsMethod
syntax keyword jsSetter set contained skipwhite skipempty nextgroup=jsMethod

" Computed property
syntax region  jsComputed matchgroup=jsComputedBrace start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAssignmentEqual,jsFunctionArgs,jsColon

" Generator
syntax match   jsGeneratorAsterisk +\*+ contained skipwhite skipempty nextgroup=jsFunctionName,jsMethod,jsComputed display
syntax match   jsYieldAsterisk +\*+ contained skipwhite skipempty nextgroup=@jsExpression display
syntax keyword jsYield yield skipwhite skipempty nextgroup=@jsExpression,jsYieldAsterisk

" Function Call
syntax region  jsFunctionCall start=+\<\K\k*\(\.\K\k*\)*\>\(\_s*(\)\@=+ end=+)\@1<=+ contains=jsFunctionCallName skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallParen
syntax match   jsFunctionCallName +\<\K\k*\>\(\_s*(\)\@=+ contained contains=jsImport,jsSuper skipwhite skipempty nextgroup=jsFunctionCallParen display
syntax region  jsFunctionCallParen matchgroup=jsFunctionCallBrace start=+(+ end=+)+ contained contains=@jsExpression,@jsOperators,jsComma,jsSpread extend skipwhite skipempty nextgroup=jsFunctionCallParen,jsAccessor

" Control flow
" If statements
syntax keyword jsIf if skipwhite skipempty nextgroup=jsCondition,jsConditionalBlock
syntax keyword jsElse else skipwhite skipempty nextgroup=jsIf,jsConditionalBlock
syntax region  jsCondition matchgroup=jsConditionBrace start=+(+ end=+)+ contained contains=@jsExpression,@jsOperators skipwhite skipempty nextgroup=jsConditionalBlock
syntax region  jsConditionalBlock matchgroup=jsConditionalBrace start=+{+ end=+}+ contained contains=TOP

" Switch statements
syntax keyword jsSwitch switch skipwhite skipempty nextgroup=jsCondition

syntax keyword jsBreak break
syntax keyword jsContinue continue
syntax keyword jsCase case contained skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsDefault default contained
syntax match   jsSwitchColon +:+ contained
syntax region  jsCaseStatement start=+\<\(case\|default\)\>+ end=+:+ contains=jsCase,jsDefault,jsSwitchColon keepend

syntax cluster jsExpression contains=jsComment,jsString,jsTemplateString,jsValueKeyword,jsNumber,jsFloat,jsArray,jsObject,jsVariable,jsAsync,jsAwait,jsYield,jsThis,jsSuper,jsFunction,jsFunctionCall,jsClass,jsParen,jsUnaryOperator


" syntax keyword jsConditional if else switch case default
" syntax keyword jsClassDeclare class

" Operators
highlight default link jsUnaryOperator Keyword
highlight default link jsOperatorArithmetic Operator
highlight default link jsOperatorComparison Operator
highlight default link jsOperatorBit Operator
highlight default link jsOperatorLogical Operator
highlight default link jsOperatorConditional Operator
highlight default link jsOperatorAssignment Operator

highlight default link jsRelationalOperator Keyword

" highlight default link jsVariable Ignore
highlight default link jsSemicolon Operator
highlight default link jsComma Operator
highlight default link jsColon Operator
highlight default link jsSpread Operator
highlight default link jsParensError Error

highlight default link jsString String
highlight default link jsTemplateString String
highlight default link jsTemplateBrace Keyword
highlight default link jsValueKeyword Constant
highlight default link jsNumber Number
highlight default link jsFloat Number

" Functions
highlight default link jsAsync Keyword
highlight default link jsAwait Keyword
highlight default link jsYield Keyword
highlight default link jsThis Keyword
highlight default link jsReturn Keyword
highlight default link jsFunction Keyword
highlight default link jsFunctionName Function
highlight default link jsMethod jsFunctionName
highlight default link jsGeneratorAsterisk Operator
highlight default link jsYieldAsterisk Operator
highlight default link jsArrow Keyword

highlight default link jsFunctionCallName Identifier

highlight default link jsGetter Keyword
highlight default link jsSetter Keyword

" Class
highlight default link jsClass Keyword
highlight default link jsExtends Keyword
highlight default link jsConstructor Keyword
highlight default link jsSuper Keyword
highlight default link jsStatic Keyword
highlight default link jsClassName Identifier
highlight default link jsClassProp Identifier


" Object
highlight default link jsObjectKey Identifier
highlight default link jsObjectKeyString String
highlight default link jsObjectDestructuringColon Operator

" Modules
highlight default link jsImport PreProc
highlight default link jsExport jsImport
highlight default link jsFrom jsImport
highlight default link jsModuleDefault Keyword
highlight default link jsModuleAsterisk Operator
highlight default link jsModuleAs jsImport
highlight default link jsModuleName jsVariable

" Comments
highlight default link jsComment Comment
highlight default link jsCommentTodo Todo

" Declaration
highlight default link jsVariableType Type
highlight default link jsVariableDeclare Identifier
highlight default link jsAssignmentEqual Operator

" Conditional Statements
highlight default link jsIf Keyword
highlight default link jsElse Keyword
highlight default link jsSwitch Keyword
highlight default link jsCase Keyword
highlight default link jsDefault Keyword
highlight default link jsSwitchColon jsColon

highlight default link jsBreak Keyword
highlight default link jsContinue Keyword


let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
