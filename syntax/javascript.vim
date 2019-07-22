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
syntax match jsSpread +\.\.\.+ display skipwhite skipempty nextgroup=@jsExpression
syntax match jsParensError +[)}\]]+

" Operators
syntax keyword jsUnaryKeyword delete void typeof new skipwhite skipempty nextgroup=@jsExpression

syntax keyword jsInstanceof instanceof skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsIn in skipwhite skipempty nextgroup=@jsExpression

syntax match   jsOperatorMath +[+*/%-]+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorRelational +\([=!]==\?\|[<>]=\?\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorBit +\([&^|~]\|<<\|>>>\?\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorNot +!+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorExpo +\*\*+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorLogical +\(||\|&&\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorConditional +[?:]+ skipwhite skipempty nextgroup=@jsExpression display

" " *=/=%=+=-=<<=>>=>>>=&=^=|=**=
syntax match   jsOperatorAssignment +\([-/%+&|^]\|<<\|>>>\?\|\*\*\?\)=+ skipwhite skipempty nextgroup=@jsExpression display

syntax cluster jsOperators contains=jsInstanceof,jsIn,jsOperator.*

" Keywords

" Modules
syntax keyword jsImport import skipwhite skipempty nextgroup=jsModuleName,jsModuleAsterisk,jsModuleBlock,jsString
syntax keyword jsFrom from contained skipwhite skipempty nextgroup=jsString
syntax match   jsModuleAsterisk +\*+ contained skipwhite skipempty nextgroup=jsModuleAs display
syntax keyword jsModuleAs as contained skipwhite skipempty nextgroup=jsModuleName
syntax region  jsModuleBlock matchgroup=jsModuleBrace start=+{+ end=+}+ contained contains=jsModuleName,jsModuleComma skipwhite skipempty nextgroup=jsFrom
syntax match   jsModuleName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFrom,jsModuleComma,jsModuleAs display
syntax match   jsModuleComma +,+ contained skipwhite skipempty nextgroup=jsModuleBlock,jsModuleName,jsModuleAsterisk display

" Comments
" Comments can be treat as a special expression which produce nothing
syntax keyword jsCommentTodo contained TODO FIXME XXX TBD
syntax region  jsComment start=+//+ end=/$/ contains=jsCommentTodo,@Spell extend keepend
syntax region  jsComment start=+/\*+  end=+\*/+ contains=jsCommentTodo,@Spell extend fold
" syntax region  jsEnvComment start=/\%^#!/ end=/$/ display

" Declaration
syntax keyword jsVariableType const let var skipwhite skipempty nextgroup=jsVariable,jsObject
syntax match   jsVariable +\<\K\k*\>+ skipwhite skipempty nextgroup=jsOperatorRelational,jsOperatorAssignment,jsAssignmentEqual,jsArrow display

" Strings, Literals, Numbers
syntax region jsString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsColon
syntax region jsTemplateString start=+`+ skip=+\\`+ end=+`+ contains=jsTemplateExpression,@Spell extend skipwhite skipempty nextgroup=jsColon
syntax region jsTemplateExpression matchgroup=jsTemplateBrace start=+${+ end=+}+ contained contains=@jsExpression

syntax keyword jsValueKeyword undefined null NaN true false

syntax match   jsNumber +\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>+ display
syntax keyword jsNumber Infinity
syntax match   jsFloat +\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>+ display

syntax region  jsBlock matchgroup=jsBlockBrace start=+{+ end=+}+ contains=TOP extend fold
syntax region  jsParen matchgroup=jsParenBrace start=+(+ end=+)+ contains=@jsExpression,@jsOperators,jsComma,jsSpread extend fold skipwhite skipempty nextgroup=jsArrow,jsParen,jsAssignmentEqual

" Array and Array Destructuring
syntax region  jsArray matchgroup=jsArrayBrace start=+\[+ end=+]+ contains=@jsExpression,@jsOperators,jsComma,jsSpread

" Object and Object Destructuring
syntax region  jsObject matchgroup=jsObjectBrace start=+{+ end=+}+ contained transparent contains=jsObjectKey,jsObjectKeyString,jsMethod,jsComputed,jsGeneratorAsterisk,jsAsync,jsGetter,jsSetter,jsComma,jsSpread,@jsOperators
syntax match   jsObjectKey +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsColon,jsAssignmentEqual display
syntax match   jsObjectKey +\d\++ contained skipwhite skipempty nextgroup=jsColon display
syntax region  jsObjectKeyString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsColon

" Class
syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassName,jsClassBody
syntax keyword jsExtends extends contained skipwhite skipempty nextgroup=jsClassName
syntax keyword jsConstructor constructor contained
syntax keyword jsSuper super contained
syntax keyword jsStatic static contained skipwhite skipempty nextgroup=jsClassProp,jsMethod
syntax match   jsClassName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsExtends,jsClassBody display
syntax region  jsClassBody matchgroup=jsClassBrace start=+{+ end=+}+ contained contains=jsAsync,jsStatic,jsSetter,jsGetter,jsClassProp,jsMethod,jsComment,jsGeneratorAsterisk,jsComputed extend fold
syntax match   jsClassProp +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsAssignmentEqual display

" Function
syntax keyword jsAsync async skipwhite skipempty nextgroup=jsFunction,jsFunctionArgs,jsGeneratorAsterisk,jsComputed
syntax keyword jsAwait await skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsThis this
syntax keyword jsReturn return skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsFunction function skipwhite skipempty nextgroup=jsGeneratorAsterisk,jsFunctionName,jsFunctionArgs
syntax match   jsFunctionName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFunctionArgs display
syntax region  jsFunctionArgs matchgroup=jsFunctionArgsBrace start=+(+ end=+)+ contained contains=@jsExpression,@jsOperators,jsComma,jsSpread skipwhite skipempty nextgroup=jsArrow,jsFunctionBody extend fold

" Match the start of the arrow function
" syntax region  jsArrowFunction matchgroup=jsFunctionArgsBrace start=+(\(\_s*(\)\@!+ end=+)\(\_s*=>\)\@=+ contains=@jsExpression,jsVariableDeclare,jsComma skipwhite skipempty nextgroup=jsArrow extend fold
" Arrow Function
syntax match   jsArrow +=>+ contained skipwhite skipempty nextgroup=@jsExpression,jsFunctionBody display
syntax region  jsFunctionBody matchgroup=jsFunctionBodyBrace start=+{+ end=+}+ contained contains=TOP extend fold

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
syntax region  jsFunctionCall start=+\(\<\K\k*\>\(\.\K\k*\)\{}\_s*(\)\@=+ end=+)\@1<=+ contains=jsFunctionCallName
syntax match   jsFunctionCallName +\<\K\k*\>\(\_s*(\)\@=+ contained contains=jsImport,jsSuper skipwhite skipempty nextgroup=jsFunctionCallParen display
syntax region  jsFunctionCallParen matchgroup=jsFunctionCallBrace start=+(+ end=+)+ contained contains=@jsExpression,@jsOperators,jsComma,jsSpread extend

syntax cluster jsExpression contains=jsComment,jsString,jsTemplateString,jsValueKeyword,jsNumber,jsFloat,jsArray,jsObject,jsVariable,jsAsync,jsAwait,jsYield,jsThis,jsFunction,jsFunctionCall,jsClass,jsParen,jsUnaryKeyword
" syntax cluster jsStatement contains=jsVariableType,jsReturn


" syntax keyword jsConditional if else switch case default
" syntax keyword jsClassDeclare class

" Operators
highlight default link jsUnaryKeyword Keyword
highlight default link jsOperatorMath Operator
highlight default link jsOperatorRelational Operator
highlight default link jsOperatorBit Operator
highlight default link jsOperatorNot Operator
highlight default link jsOperatorExpo Operator
highlight default link jsOperatorLogical Operator
highlight default link jsOperatorConditional Operator
highlight default link jsOperatorAssignment Operator

highlight default link jsInstanceof Keyword
highlight default link jsIn Keyword

" highlight default link jsVariable Ignore
highlight default link jsSemicolon Operator
highlight default link jsComma Operator
highlight default link jsColon Operator
highlight default link jsSpread Operator

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

" Modules
highlight default link jsImport PreProc
highlight default link jsFrom jsImport
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

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
