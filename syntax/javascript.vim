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
syntax case match

" Basic tokens
syntax keyword jsDebugger debugger
syntax match   jsSemicolon +;+ display
syntax match   jsComma +,+ display
syntax match   jsColonAssignment +:+ contained skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsAssignmentEqual +=+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsPrivateIdentifier +#+ nextgroup=jsIdentifier,jsFunctionCall display
syntax match   jsDot +\.+ skipwhite skipempty nextgroup=jsPrivateIdentifier,jsIdentifier,jsFunctionCall display
syntax match   jsSpread +\.\.\.+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsParensError +[)}\]]+ display

" Operators
" REFERENCE: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators
syntax keyword jsUnaryOperator delete void typeof skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsRelationalOperator in instanceof skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperatorArithmetic +\([+*-]\{1,2}\|%\|/\ze[^/*]\)+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperatorComparison +\([=!]==\?\|[<>]=\?\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorBit +\([&^|~]\|<<\|>>>\?\)+ skipwhite skipempty nextgroup=@jsExpression display
syntax match   jsOperatorLogical +\(!\|[|&]\{2}\)+ skipwhite skipempty nextgroup=@jsExpression display
" " *=/=%=+=-=<<=>>=>>>=&=^=|=**=
syntax match   jsOperatorAssignment +\([-/%+&|^]\|<<\|>>>\?\|\*\*\?\)=+ skipwhite skipempty nextgroup=@jsExpression display
syntax region  jsTernary matchgroup=jsTernaryOperator start=+?+ end=+:+ contained contains=@jsExpression skipwhite skipempty nextgroup=@jsExpression

syntax match   jsOptionalOperator +?\.+ contained skipwhite skipempty nextgroup=jsIdentifier,jsAccessor,jsFunctionCall,jsFunctionCallParen 
syntax match   jsOperatorNullish +??+ contained skipwhite skipwhite nextgroup=@jsExpression

syntax cluster jsOperators contains=jsRelationalOperator,jsTernary,jsOperator.*

" Modules
" REFERENCE:
"   - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import
"   - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export
syntax keyword jsImport import skipwhite skipempty nextgroup=jsModuleName,jsModuleAsterisk,jsModuleBlock,jsString,jsDecoratorName
syntax keyword jsExport export skipwhite skipempty nextgroup=jsVariableType,jsFunction,jsClass,jsDecorator,jsModuleBlock,jsModuleDefault,jsModuleAsterisk
syntax keyword jsFrom from contained skipwhite skipempty nextgroup=jsString
syntax keyword jsModuleDefault default contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsModuleAsterisk +\*+ contained skipwhite skipempty nextgroup=jsModuleAs,jsFrom display
syntax keyword jsModuleAs as contained skipwhite skipempty nextgroup=jsModuleName
syntax region  jsModuleBlock matchgroup=jsModuleBrace start=+{+ end=+}+ contained contains=jsModuleName,jsModuleComma,jsComment,jsDecoratorName skipwhite skipempty nextgroup=jsFrom
syntax match   jsModuleName +\<\K\k*\>+ contained contains=jsModuleDefault skipwhite skipempty nextgroup=jsFrom,jsModuleComma,jsModuleAs display
syntax match   jsModuleComma +,+ contained skipwhite skipempty nextgroup=jsModuleBlock,jsModuleName,jsModuleAsterisk display

" RegExp
syntax region  jsRegexp matchgroup=jsRegexpSlashes start=+/+ skip=+\\/+ end=+/+ contains=@jsRegexpTokens,jsRegexpError nextgroup=jsRegexpFlags
syntax match   jsRegexpFlags +[gimsuy]\++ contained display
syntax match   jsRegexpChars +.+ contained display
syntax match   jsRegexpError +)+ contained display

syntax match   jsRegexpEscape +\\+ contained nextgroup=jsRegexpChars
syntax match   jsRegexpOr +|+ contained display
syntax match   jsRegexpQuantifier +[*?+]\|{\d\+\%(,\d*\)\?}+ contained display
syntax match   jsRegexpGroupReference +\\[1-9]\d*+ contained display
syntax match   jsRegexpRangeHyphen +\[\@1<!-]\@!+ contained display
syntax match   jsRegexpRangeCaret +\[\@1<=\^+ contained display
syntax match   jsRegexpDot +\.+ contained display
syntax match   jsRegexpCharClass +\\[bBdDwWsStrnvf0]\|\\c\u\|\\x\x\{2}\|\\u\x\{4}\|\\u{\x\{4,5}}+ contained display
syntax match   jsRegexpBoundaries +[$^]\|\\[Bb]+ contained display
syntax region  jsRegexpUnicode matchgroup=jsRegexpUnicodeBraces start=+\\p{+ end=+}+ contained contains=jsRegexpUnicodeName
syntax match   jsRegexpUnicodeName +\K\k*+ contained nextgroup=jsRegexpUnicodeEqual display
syntax match   jsRegexpUnicodeEqual +=+ contained nextgroup=jsRegexpUnicodeValue display
syntax match   jsRegexpUnicodeValue +\K\k*+ contained display

syntax region  jsRegexpGroup matchgroup=jsRegexpGroupParens start=+(\%(?\%(:\|<\K\k*>\)\)\?+ end=+)+ contained contains=@jsRegexpTokens
syntax region  jsRegexpRange matchgroup=jsRegexpRangeBrackets start=+\[+ end=+]+ contained contains=jsRegexpChars,jsRegexpCharClass,jsRegexpRangeHyphen,jsRegexpRangeCaret
syntax region  jsRegexpAssertion matchgroup=jsRegexpAssertionParens start=+(?<\?[=!]+ end=+)+ contained contains=@jsRegexpTokens

syntax cluster jsRegexpTokens contains=jsRegexpChars,jsRegexpGroup,jsRegexpGroupReference,jsRegexpOr,jsRegexpRange,jsRegexpAssertion,jsRegexpBoundaries,jsRegexpQuantifier,jsRegexpEscape,jsRegexpDot,jsRegexpCharClass,jsRegexpUnicode

" Comments
" Comments can be treat as a special expression which produce nothing, so
" I added it to the expression cluster
syntax keyword jsCommentTodo contained TODO FIXME XXX TBD
syntax region  jsComment start=+//+ end=/$/ contains=jsCommentTodo,@Spell extend keepend skipwhite skipempty nextgroup=@jsOperators
syntax region  jsComment start=+/\*+  end=+\*/+ contains=jsCommentTodo,@Spell extend fold skipwhite skipempty nextgroup=@jsOperators
syntax region  jsHashbangComment start=+^#!+ end=+$+

" Declaration
syntax keyword jsVariableType const let var skipwhite skipempty nextgroup=jsIdentifier,jsObjectDestructuring,jsArrayDestructuring
syntax match   jsIdentifier +\<\K\k*\>+ contains=@jsGlobalValues,jsTemplateStringTag skipwhite skipempty nextgroup=jsOperatorComparison,jsOperatorAssignment,jsAssignmentEqual,jsArrow,jsAccessor,jsDot,jsOptionalOperator,@jsOperators

" Strings
syntax region  jsString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsAccessor,@jsOperators
syntax match   jsTemplateStringTag +\<\K\k*\>\(\_s*`\)\@=+ skipwhite skipempty nextgroup=jsTemplateString display
syntax region  jsTemplateString start=+`+ skip=+\\`+ end=+`+ contains=jsTemplateExpression,@Spell skipwhite skipempty nextgroup=jsAccessor,@jsOperators
syntax region  jsTemplateExpression matchgroup=jsTemplateBrace start=+\\\@1<!${+ end=+}+ contained contains=@jsExpression,@jsOperators

" Built-in values
syntax keyword jsBuiltinValues undefined null NaN true false Infinity Symbol contained

" Numbers
" REFERENCE: http://www.ecma-international.org/ecma-262/10.0/index.html#prod-NumericLiteral
syntax match   jsNumber +\c[+-]\?\%(0b[01]\%(_\?[01]\)*\|0o\o\%(_\?\o\)*\|0x\x\%(_\?\x\)*\|\%(\%(\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\.\%(\d\%(_\?\d\)*\)\?\|\.\d\%(_\?\d\)*\|\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\)\%(e[+-]\?\d\%(_\?\d\)*\)\?\)\)+ contains=jsNumberDot,jsNumberSeparator skipwhite skipempty nextgroup=jsAccessor,@jsOperators display
syntax match   jsNumberDot +\.+ contained display
syntax match   jsNumberSeparator +_+ contained display

" Code blocks
syntax region  jsBlock matchgroup=jsBraces start=+{+ end=+}+ contains=TOP extend fold
syntax region  jsParen matchgroup=jsParens start=+(+ end=+)+ contains=@jsExpression,jsComma,jsSpread extend fold skipwhite skipempty nextgroup=jsArrow,jsFunctionCallParen,jsAccessor,@jsOperators

" Array
syntax region  jsArray matchgroup=jsBrackets start=+\[+ end=+]+ contains=@jsExpression,jsComma,jsSpread skipwhite skipempty nextgroup=jsAccessor,@jsOperators

" Object
syntax region  jsObject matchgroup=jsObjectBrace start=+{+ end=+}+ contained contains=jsComment,jsIdentifier,jsObjectKey,jsObjectKeyString,jsTemplateString,jsMethod,jsComputed,jsGeneratorAsterisk,jsAsync,jsMethodType,jsComma,jsSpread,jsDot,jsOptionalOperator,@jsOperators,jsObject
syntax match   jsObjectKey +\<\k\+\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsColonAssignment display
syntax region  jsObjectKeyString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsColonAssignment

" Property accessor, e.g., arr[1] or obj["prop"]
syntax region  jsAccessor matchgroup=jsAccessorBrace start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallParen,jsOptionalOperator,@jsOperators

" Array Destructuring
" Cases like [a, b] = [1, 2] and the array destructuring in the arrow function arguments cannot be highlighted
" as array destructuring, they are highlighted as Array, but it doesn't break the syntax
syntax region  jsArrayDestructuring matchgroup=jsDestructuringBrace start=+\[+ end=+]+ contained contains=jsComment,jsIdentifier,jsComma,jsObjectDestructuring,jsArrayDestructuring,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual

" Object Destructuring
" Cases like ({a, b} = {a: 1, b: 2}) and the object destructuring in the arrow function arguments cannot be highlighted
" as object destructuring, they are highlighted as Object, but it doesn't break the syntax
syntax region  jsObjectDestructuring matchgroup=jsDestructuringBrace start=+{+ end=+}+ contained contains=jsComment,jsObjectDestructuringKey,jsIdentifier,jsComma,jsObjectDestructuring,jsArrayDestructuring,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual
syntax match   jsObjectDestructuringKey +\<\K\k*\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsAssignmentEqual,jsObjectDestructuringColon display
syntax match   jsObjectDestructuringColon +:+ contained skipwhite skipempty nextgroup=jsIdentifier,jsObjectDestructuring,jsArrayDestructuring display

" Class
syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassName,jsClassBody
syntax keyword jsExtends extends contained skipwhite skipempty nextgroup=jsClassName
syntax keyword jsConstructor constructor contained
syntax keyword jsSuper super contained
syntax keyword jsStatic static contained skipwhite skipempty nextgroup=jsClassProp,jsMethod
syntax match   jsClassName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsExtends,jsClassBody
syntax region  jsClassBody matchgroup=jsClassBrace start=+{+ end=+}+ contained contains=jsComment,jsAsync,jsStatic,jsMethodType,jsClassPrivate,jsClassProp,jsMethod,jsFunctionArgs,jsGeneratorAsterisk,jsComputed,jsDot,jsOptionalOperator,@jsOperators,jsDecoratorName,jsDecoratorParams extend fold
syntax match   jsClassProp +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsAssignmentEqual display
syntax match   jsClassPrivate +#+ contained nextgroup=jsClassProp,jsMethod display

syntax keyword jsNew new skipwhite skipempty nextgroup=jsClassNew
syntax match   jsClassNew +\K\k*\%(\.\K\k*\)*+ contained contains=jsNewDot skipwhite skipempty nextgroup=jsClassNewArgs display
syntax region  jsClassNewArgs matchgroup=jsClassNewBrace start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread skipwhite skipempty nextgroup=jsFunctionCallParen,jsAccessor,jsOptionalOperator,@jsOperators
syntax match   jsNewDot +\.+ contained display

" Decorator
" REFERENCE: https://github.com/tc39/proposal-decorators
syntax keyword jsDecorator decorator skipwhite skipempty nextgroup=jsDecoratorName
syntax match   jsDecoratorName +@\K\k*+ skipwhite skipempty nextgroup=jsDecoratorBlock,jsDecoratorParams,jsFrom
syntax region  jsDecoratorParams matchgroup=jsDecoratorParens start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread nextgroup=jsDecoratorBlock
syntax region  jsDecoratorBlock matchgroup=jsDecoratorBraces start=+{+ end=+}+ contained contains=jsDecoratorName,jsDecoratorParams

" Function
syntax keyword jsAsync async skipwhite skipempty nextgroup=jsFunction,jsFunctionArgs,jsGeneratorAsterisk,jsComputed
syntax keyword jsAwait await skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsThis this contained
syntax keyword jsReturn return skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsFunction function skipwhite skipempty nextgroup=jsGeneratorAsterisk,jsFunctionName,jsFunctionArgs
syntax match   jsFunctionName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFunctionArgs display
syntax region  jsFunctionArgs matchgroup=jsFunctionArgsBrace start=+(+ end=+)+ contained contains=jsComment,jsIdentifier,jsComma,jsSpread,jsObjectDestructuring,jsArrayDestructuring skipwhite skipempty nextgroup=jsArrow,jsFunctionBody extend fold
syntax region  jsFunctionBody matchgroup=jsFunctionBodyBrace start=+{+ end=+}+ contained contains=TOP extend fold

" Arrow Function
syntax match   jsArrow +=>+ contained skipwhite skipempty nextgroup=@jsExpression,jsFunctionBody display

" Object method
syntax match   jsMethod +\<\K\k*\>\(\_s*(\)\@=+ contains=jsConstructor skipwhite skipempty nextgroup=jsFunctionArgs display
syntax match   jsMethodType +\<[sg]et\>+ contained skipwhite skipempty nextgroup=jsMethod display

" Computed property
syntax region  jsComputed matchgroup=jsComputedBrace start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAssignmentEqual,jsFunctionArgs,jsColonAssignment

" Generator
syntax match   jsGeneratorAsterisk +\*+ contained skipwhite skipempty nextgroup=jsFunctionName,jsMethod,jsComputed
syntax match   jsYieldAsterisk +\*+ contained skipwhite skipempty nextgroup=@jsExpression display
syntax keyword jsYield yield skipwhite skipempty nextgroup=@jsExpression,jsYieldAsterisk

" Function Call
syntax match   jsFunctionCall +\<\K\k*\>\%(\_s*\%(?\.\)\?\_s*(\)\@=+ contains=jsImport,jsSuper skipwhite skipempty nextgroup=jsOptionalOperator,jsFunctionCallParen
syntax region  jsFunctionCallParen matchgroup=jsFunctionCallBrace start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread skipwhite skipempty nextgroup=jsFunctionCallParen,jsAccessor,jsOptionalOperator,@jsOperators

" Loops
syntax keyword jsFor for skipwhite skipempty nextgroup=jsLoopCondition
syntax keyword jsOf of skipwhite skipempty nextgroup=@jsExpression
syntax region  jsLoopCondition matchgroup=jsLoopConditionBrace start=+(+ end=+)+ contained contains=@jsExpression,jsOf,jsVariableType,jsSemicolon skipwhite skipempty nextgroup=jsLoopBlock
syntax region  jsLoopBlock matchgroup=jsLoopBrace start=+{+ end=+}+ contained contains=TOP skipwhite skipempty nextgroup=jsWhile

syntax keyword jsDo do skipwhite skipempty nextgroup=jsLoopBlock
syntax keyword jsWhile while skipwhite skipempty nextgroup=jsLoopCondition

syntax keyword jsBreak break skipwhite skipempty nextgroup=jsLabelText
syntax keyword jsContinue continue skipwhite skipempty nextgroup=jsLabelText

syntax match   jsLabel +\<\K\k*\>\_s*:+ contains=jsLabelText skipwhite skipempty nextgroup=jsBlock,jsFor,jsDo,jsWhile display
syntax match   jsLabelText +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsLabelColon display
syntax match   jsLabelColon +:+ contained display

" Control flow
" If statements
syntax keyword jsIf if skipwhite skipempty nextgroup=jsCondition,jsConditionalBlock
syntax keyword jsElse else skipwhite skipempty nextgroup=jsIf,jsConditionalBlock
syntax region  jsCondition matchgroup=jsConditionBrace start=+(+ end=+)+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsConditionalBlock
syntax region  jsConditionalBlock matchgroup=jsConditionalBrace start=+{+ end=+}+ contained contains=TOP

" Switch statements
syntax keyword jsSwitch switch skipwhite skipempty nextgroup=jsCondition
syntax region  jsCaseStatement matchgroup=jsSwitchCase start=+\<\(case\|default\)\>+ matchgroup=jsSwitchColon end=+:+ contains=jsComment,@jsExpression keepend

" Exceptions
syntax keyword jsTry try skipwhite skipempty nextgroup=jsBlock
syntax keyword jsCatch catch skipwhite skipempty nextgroup=jsBlock,jsParen
syntax keyword jsFinally finally skipwhite skipempty nextgroup=jsBlock
syntax keyword jsThrow throw skipwhite skipempty nextgroup=@jsExpression

" with
syntax keyword jsWith with skipwhite skipempty nextgroup=jsWithParen
syntax region  jsWithParen matchgroup=jsWithBrace start=+(+ end=+)+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsBlock

syntax cluster jsGlobalValues contains=jsBuiltinValues,jsThis,jsSuper
syntax cluster jsExpression contains=jsRegexp,jsComment,jsString,jsTemplateString,jsNumber,jsArray,jsObject,jsIdentifier,jsAsync,jsAwait,jsYield,jsFunction,jsFunctionCall,jsClass,jsParen,jsUnaryOperator,jsNew

" Operators
highlight default link jsUnaryOperator Keyword
highlight default link jsOperatorArithmetic Operator
highlight default link jsOperatorComparison Operator
highlight default link jsOperatorBit Operator
highlight default link jsOperatorLogical Operator
highlight default link jsOperatorConditional Operator
highlight default link jsOperatorAssignment Operator

highlight default link jsRelationalOperator Keyword
highlight default link jsOptionalOperator Operator
highlight default link jsOperatorNullish Operator

" highlight default link jsIdentifier Ignore
highlight default link jsPrivateIdentifier Type
highlight default link jsSemicolon Operator
highlight default link jsComma Operator
highlight default link jsColonAssignment Operator
highlight default link jsSpread Operator
highlight default link jsParensError Error

highlight default link jsString String
highlight default link jsTemplateStringTag Identifier
highlight default link jsTemplateString String
highlight default link jsTemplateBrace Keyword
highlight default link jsBuiltinValues Constant
highlight default link jsNumber Number
highlight default link jsNumberDot Special
highlight default link jsNumberSeparator Number

" RegExp
highlight default link jsRegexpError Error
highlight default link jsRegexpSlashes Special
highlight default link jsRegexpFlags Keyword
highlight default link jsRegexpChars String

highlight default link jsRegexpQuantifier Special
highlight default link jsRegexpOr Special
highlight default link jsRegexpEscape Special
highlight default link jsRegexpRangeHyphen Special
highlight default link jsRegexpRangeCaret Special
highlight default link jsRegexpBoundaries Special

highlight default link jsRegexpDot Character
highlight default link jsRegexpCharClass Character
highlight default link jsRegexpUnicodeBraces Special
highlight default link jsRegexpUnicodeName Keyword
highlight default link jsRegexpUnicodeEqual Special
highlight default link jsRegexpUnicodeValue Constant

highlight default link jsRegexpGroupParens Special
highlight default link jsRegexpGroupReference Keyword
highlight default link jsRegexpRangeBrackets Special
highlight default link jsRegexpAssertionParens Special

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

highlight default link jsFunctionCall Identifier

highlight default link jsMethodType Type

" Class
highlight default link jsClass Keyword
highlight default link jsExtends Keyword
highlight default link jsConstructor Keyword
highlight default link jsSuper Keyword
highlight default link jsStatic Keyword
highlight default link jsClassName Identifier
highlight default link jsClassProp Identifier
highlight default link jsClassPrivate Type
highlight default link jsNew Keyword
highlight default link jsClassNew Identifier

" Decorator
highlight default link jsDecorator Keyword
highlight default link jsDecoratorName Type

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
highlight default link jsModuleName jsIdentifier

" Comments
highlight default link jsComment Comment
highlight default link jsHashbangComment PreProc
highlight default link jsCommentTodo Todo

" Declaration
highlight default link jsVariableType Type
highlight default link jsVariableDeclare Identifier
highlight default link jsAssignmentEqual Operator

" Conditional Statements
highlight default link jsIf Keyword
highlight default link jsElse Keyword
highlight default link jsSwitch Keyword
highlight default link jsSwitchCase Keyword
highlight default link jsSwitchColon Operator
highlight default link jsBreak Keyword
highlight default link jsContinue Keyword

" Loops
highlight default link jsFor Keyword
highlight default link jsOf Keyword
highlight default link jsDo Keyword
highlight default link jsWhile Keyword
highlight default link jsLabelText Identifier
highlight default link jsLabelColon Operator

" Exceptions
highlight default link jsTry Keyword
highlight default link jsCatch Keyword
highlight default link jsFinally Keyword
highlight default link jsThrow Keyword

" with
highlight default link jsWith Keyword

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
