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
syntax match   jsSemicolon +;+
syntax match   jsComma +,+ contained
syntax match   jsAssignmentColon +:+ contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsAssignmentEqual +=+ contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsPrivateIdentifier +#+ contained nextgroup=jsIdentifier,jsFunctionCall
syntax match   jsDot +\.+ contained skipwhite skipempty nextgroup=jsPrivateIdentifier,jsIdentifier,jsFunctionCall
syntax match   jsSpread +\.\.\.+ contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsParensError +[)}\]]+

" Code blocks
syntax region  jsBlock matchgroup=jsBraces start=+{+ end=+}+ contains=@jsTop extend fold
syntax region  jsParen matchgroup=jsParens start=+(+ end=+)+ contains=@jsExpression,jsComma,jsSpread,@jsOperators extend fold skipwhite skipempty nextgroup=jsArrow,jsFunctionCallArgs,jsAccessor,jsDot,@jsOperators,jsFlowColon

" Operators
" REFERENCE: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators
syntax keyword jsUnaryOperator delete void typeof skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsRelationalOperator in instanceof contained skipwhite skipempty nextgroup=@jsExpression
" Arithmetic operators (%, ++, --, -, +, **, /)
syntax match   jsOperator +\([+*-]\{1,2}\|%\|/\ze[^/*]\)+ skipwhite skipempty nextgroup=@jsExpression
" Comparison operators (==, !=, ===, !==, >, >=, <, <=)
syntax match   jsOperator +\([=!]==\?\|[<>]=\?\)+ skipwhite skipempty nextgroup=@jsExpression
" Bitwise operators (&, |, ^, ~, <<, >>, >>>)
syntax match   jsOperator +\([&^|~]\|<<\|>>>\?\)+ skipwhite skipempty nextgroup=@jsExpression
" Logical operators (&&, ||, !)
syntax match   jsOperator +\(!\|[|&]\{2}\)+ skipwhite skipempty nextgroup=@jsExpression
" Assignment operators (*=, /=, %=, +=, -=, <<=, >>=, >>>=, &=, ^=, |=, **=)
syntax match   jsOperator +\([-/%+&|^]\|<<\|>>>\?\|\*\*\?\)=+ skipwhite skipempty nextgroup=@jsExpression
" Ternary expression
syntax region  jsTernary matchgroup=jsTernaryOperator start=+?+ end=+:+ contained contains=@jsExpression skipwhite skipempty nextgroup=@jsExpression
" Optional chaining operator: https://github.com/TC39/proposal-optional-chaining
syntax match   jsOptionalOperator +?\.+ contained skipwhite skipempty nextgroup=jsIdentifier,jsAccessor,jsFunctionCall,jsFunctionCallArgs 
" Nullish coalescing operator: https://github.com/tc39/proposal-nullish-coalescing
syntax match   jsOperator +??+ contained skipwhite skipwhite nextgroup=@jsExpression

syntax cluster jsOperators contains=jsRelationalOperator,jsTernary,jsOperator

" Modules
" REFERENCE:
"   - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import
"   - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export
syntax keyword jsImport import skipwhite skipempty nextgroup=jsModuleName,jsModuleAsterisk,jsModuleBlock,jsString,jsDecoratorName,jsFlowModuleType,jsFlowModuleTypeof
syntax keyword jsExport export skipwhite skipempty nextgroup=jsVariableType,jsFunction,jsClass,jsDecorator,jsModuleBlock,jsModuleDefault,jsModuleAsterisk
syntax keyword jsFrom from contained skipwhite skipempty nextgroup=jsString
syntax keyword jsModuleDefault default contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsModuleAsterisk +\*+ contained skipwhite skipempty nextgroup=jsModuleAs,jsFrom
syntax keyword jsModuleAs as contained skipwhite skipempty nextgroup=jsModuleName
syntax region  jsModuleBlock matchgroup=jsModuleBraces start=+{+ end=+}+ contained contains=jsModuleName,jsModuleComma,jsComment,jsDecoratorName skipwhite skipempty nextgroup=jsFrom
syntax match   jsModuleName +\<\K\k*\>+ contained contains=jsModuleDefault skipwhite skipempty nextgroup=jsFrom,jsModuleComma,jsModuleAs
syntax match   jsModuleComma +,+ contained skipwhite skipempty nextgroup=jsModuleBlock,jsModuleName,jsModuleAsterisk

" RegExp
syntax region  jsRegexp matchgroup=jsRegexpSlashes start=+/+ skip=+\\/+ end=+/+ contains=@jsRegexpTokens,jsRegexpError nextgroup=jsRegexpFlags
syntax match   jsRegexpFlags +[gimsuy]\++ contained
syntax match   jsRegexpChars +.+ contained
syntax match   jsRegexpError +)+ contained

" Escape token
syntax match   jsRegexpEscape +\\+ contained nextgroup=jsRegexpChars
" Or
syntax match   jsRegexpOr +|+ contained
" Quantifier tokens (x*, x+, x?, x{n}, x{n,}, x{n,m}, x*?, x+?, x??, x{n}?, x{n,}?, x{n,m}?)
syntax match   jsRegexpQuantifier +[*?+]\|{\d\+\%(,\d*\)\?}+ contained
" Group back reference (\n)
syntax match   jsRegexpGroupReference +\\[1-9]\d*+ contained
" Match hyphen (-) inside the range. [a-z], [0-9], but don't match [-a] and [a-]
syntax match   jsRegexpRangeHyphen +\[\@1<!-]\@!+ contained
" Match caret (^) at the start of the range. [^a-z], don't match [a-z^]
syntax match   jsRegexpRangeCaret +\[\@1<=\^+ contained
" Match the dot
syntax match   jsRegexpDot +\.+ contained
" Match all the character classes
syntax match   jsRegexpCharClass +\\[bBdDwWsStrnvf0]\|\\c\u\|\\x\x\{2}\|\\u\x\{4}\|\\u{\x\{4,5}}+ contained
" Match the boundaries
syntax match   jsRegexpBoundaries +[$^]\|\\[Bb]+ contained
" Match The unicode range
syntax region  jsRegexpUnicode matchgroup=jsRegexpUnicodeBraces start=+\\p{+ end=+}+ contained contains=jsRegexpUnicodeName
syntax match   jsRegexpUnicodeName +\K\k*+ contained nextgroup=jsRegexpUnicodeEqual
syntax match   jsRegexpUnicodeEqual +=+ contained nextgroup=jsRegexpUnicodeValue
syntax match   jsRegexpUnicodeValue +\K\k*+ contained

" Match the groups. (x), (?<Name>x), (?:x)
syntax region  jsRegexpGroup matchgroup=jsRegexpGroupParens start=+(\%(?\%(:\|<\K\k*>\)\)\?+ end=+)+ contained contains=@jsRegexpTokens
" Match the range. [a-b]
syntax region  jsRegexpRange matchgroup=jsRegexpRangeBrackets start=+\[+ end=+]+ contained contains=jsRegexpEscape,jsRegexpChars,jsRegexpCharClass,jsRegexpRangeHyphen,jsRegexpRangeCaret
" Match the assertions. x(?=y), x(?!y), (?<=y)x, (?<!y)x
syntax region  jsRegexpAssertion matchgroup=jsRegexpAssertionParens start=+(?<\?[=!]+ end=+)+ contained contains=@jsRegexpTokens

syntax cluster jsRegexpTokens contains=jsRegexpChars,jsRegexpGroup,jsRegexpGroupReference,jsRegexpOr,jsRegexpRange,jsRegexpAssertion,jsRegexpBoundaries,jsRegexpQuantifier,jsRegexpEscape,jsRegexpDot,jsRegexpCharClass,jsRegexpUnicode

" Comments
" Comments can be treat as a special expression which produces nothing, so I added it to the expression cluster
syntax keyword jsCommentTodo contained TODO FIXME XXX TBD
syntax region  jsComment start=+//+ end=/$/ contains=jsCommentTodo,@Spell keepend
syntax region  jsComment start=+/\*+  end=+\*/+ contains=jsCommentTodo,@Spell,jsDocTags,jsDocInline fold keepend
syntax region  jsHashbangComment start=+^#!+ end=+$+

" Declaration
syntax keyword jsVariableType const let var skipwhite skipempty nextgroup=jsIdentifier,jsObjectDestructuring,jsArrayDestructuring
syntax match   jsIdentifier +\<\K\k*\>+ contains=@jsGlobals,jsTemplateStringTag skipwhite skipempty nextgroup=jsAssignmentEqual,jsComma,jsArrow,jsAccessor,jsDot,jsOptionalOperator,@jsOperators,jsFlowColon

" Strings
syntax region  jsString start=+\z(["']\)+ skip=+\\\\\|\\\z1\|\\\n+ end=+\z1+ contains=@Spell skipwhite skipempty nextgroup=jsAccessor,jsDot,@jsOperators,jsFlowColon
syntax match   jsTemplateStringTag +\<\K\k*\>\(\_s*`\)\@=+ skipwhite skipempty nextgroup=jsTemplateString
syntax region  jsTemplateString start=+`+ skip=+\\\\\|\\`\|\\\n+ end=+`+ contains=jsTemplateExpression,@Spell skipwhite skipempty nextgroup=jsAccessor,jsDot,@jsOperators,jsFlowColon keepend
syntax region  jsTemplateExpression matchgroup=jsTemplateBrace start=+\%([^\\]\%(\\\\\)*\)\@<=${+ end=+}+ contained contains=@jsExpression,@jsOperators

" Built-in values
syntax keyword jsBuiltinValues undefined null NaN true false Infinity Symbol contained

" Numbers
" REFERENCE: http://www.ecma-international.org/ecma-262/10.0/index.html#prod-NumericLiteral
syntax match   jsNumber +\c[+-]\?\%(0b[01]\%(_\?[01]\)*\|0o\o\%(_\?\o\)*\|0x\x\%(_\?\x\)*\|\%(\%(\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\.\%(\d\%(_\?\d\)*\)\?\|\.\d\%(_\?\d\)*\|\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\)\%(e[+-]\?\d\%(_\?\d\)*\)\?\)\)+ contains=jsNumberDot,jsNumberSeparator skipwhite skipempty nextgroup=jsAccessor,@jsOperators,jsFlowColon
syntax match   jsNumberDot +\.+ contained
syntax match   jsNumberSeparator +_+ contained

" Array
syntax region  jsArray matchgroup=jsBrackets start=+\[+ end=+]+ contains=@jsExpression,jsComma,jsSpread skipwhite skipempty nextgroup=jsAccessor,jsDot,@jsOperators,jsFlowColon

" Object
syntax region  jsObject matchgroup=jsObjectBraces start=+{+ end=+}+ contained contains=jsComment,jsIdentifier,jsObjectKey,jsObjectKeyString,jsMethod,jsComputed,jsGeneratorAsterisk,jsAsync,jsMethodType,jsComma,jsSpread skipwhite skipempty nextgroup=jsFlowColon
syntax match   jsObjectKey +\<\k\+\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsAssignmentColon
syntax region  jsObjectKeyString start=+\z(["']\)+ skip=+\\\\\|\\\z1\|\\\n+ end=+\z1+ contained contains=@Spell skipwhite skipempty nextgroup=jsAssignmentColon

" Property accessor, e.g., arr[1] or obj["prop"]
syntax region  jsAccessor matchgroup=jsAccessorBrackets start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallArgs,jsDot,jsOptionalOperator,@jsOperators,jsFlowColon

" Array Destructuring
" Cases like [a, b] = [1, 2] and the array destructuring in the arrow function arguments cannot be highlighted
" as array destructuring, they are highlighted as Array, but it doesn't break the syntax
syntax region  jsArrayDestructuring matchgroup=jsDestructuringBrackets start=+\[+ end=+]+ contained contains=jsComment,jsIdentifier,jsComma,jsSpread,jsObjectDestructuring,jsArrayDestructuring skipwhite skipempty nextgroup=jsAssignmentEqual,jsFlowColon

" Object Destructuring
" Cases like ({a, b} = {a: 1, b: 2}) and the object destructuring in the arrow function arguments cannot be highlighted
" as object destructuring, they are highlighted as Object, but it doesn't break the syntax
syntax region  jsObjectDestructuring matchgroup=jsDestructuringBraces start=+{+ end=+}+ contained contains=jsComment,jsObjectDestructuringKey,jsIdentifier,jsComma,jsObjectDestructuring,jsArrayDestructuring,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual,jsFlowColon
syntax match   jsObjectDestructuringKey +\<\K\k*\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsObjectDestructuringColon
syntax match   jsObjectDestructuringColon +:+ contained skipwhite skipempty nextgroup=jsIdentifier,jsObjectDestructuring,jsArrayDestructuring

" Class
syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassName,jsClassBody
syntax keyword jsExtends extends contained skipwhite skipempty nextgroup=jsClassName
syntax keyword jsConstructor constructor contained
syntax keyword jsSuper super contained
syntax keyword jsStatic static contained skipwhite skipempty nextgroup=jsClassProp,jsMethod
syntax match   jsClassName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsExtends,jsClassBody,jsFlowGenericDeclare,jsFlowImplments
syntax region  jsClassBody matchgroup=jsClassBraces start=+{+ end=+}+ contained contains=jsComment,jsAsync,jsStatic,jsMethodType,jsClassPrivate,jsClassProp,jsMethod,jsGeneratorAsterisk,jsComputed,jsDecoratorName,jsDecoratorParams,jsSemicolon fold
syntax match   jsClassProp +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsAssignmentEqual,jsFlowColon
syntax match   jsClassPrivate +#+ contained nextgroup=jsClassProp,jsMethod

syntax keyword jsNew new skipwhite skipempty nextgroup=jsNewClassName
syntax match   jsNewClassName +\K\k*\%(\.\K\k*\)*+ contained contains=jsNewDot skipwhite skipempty nextgroup=jsNewClassArgs,jsFlowGenericCall
syntax region  jsNewClassArgs matchgroup=jsNewClassParens start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread,@jsOperators skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallArgs,jsDot,jsOptionalOperator,@jsOperators
syntax match   jsNewDot +\.+ contained

" Decorator
" REFERENCE: https://github.com/tc39/proposal-decorators
syntax keyword jsDecorator decorator skipwhite skipempty nextgroup=jsDecoratorName
syntax match   jsDecoratorName +@\K\k*\>+ skipwhite skipempty nextgroup=jsDecoratorBlock,jsDecoratorParams,jsFrom
syntax region  jsDecoratorParams matchgroup=jsDecoratorParens start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread,@jsOperators nextgroup=jsDecoratorBlock
syntax region  jsDecoratorBlock matchgroup=jsDecoratorBraces start=+{+ end=+}+ contained contains=jsComment,jsDecoratorName,jsDecoratorParams

" Function
syntax keyword jsAsync async skipwhite skipempty nextgroup=jsFunction,jsFunctionArgs,jsGeneratorAsterisk,jsComputed
syntax keyword jsAwait await skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsThis this contained
syntax keyword jsReturn return skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsFunction function skipwhite skipempty nextgroup=jsGeneratorAsterisk,jsFunctionName,jsFunctionArgs
syntax match   jsFunctionName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFunctionArgs,jsFlowGenericDeclare
syntax region  jsFunctionArgs matchgroup=jsFunctionParens start=+(+ end=+)+ contained contains=jsComment,jsIdentifier,jsComma,jsSpread,jsObjectDestructuring,jsArrayDestructuring skipwhite skipempty nextgroup=jsArrow,jsFunctionBody,jsFlowColon fold
syntax region  jsFunctionBody matchgroup=jsFunctionBraces start=+{+ end=+}+ contained contains=@jsTop fold

" Arrow Function
syntax match   jsArrow +=>+ contained skipwhite skipempty nextgroup=@jsExpression,jsFunctionBody

" Object method
syntax match   jsMethod +\<\K\k*\>\(\_s*(\)\@=+ contained contains=jsConstructor skipwhite skipempty nextgroup=jsFunctionArgs
syntax match   jsMethodType +\<[sg]et\>+ contained skipwhite skipempty nextgroup=jsMethod

" Computed property
syntax region  jsComputed matchgroup=jsComputedBrackets start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAssignmentEqual,jsFunctionArgs,jsAssignmentColon

" Generator
syntax match   jsGeneratorAsterisk +\*+ contained skipwhite skipempty nextgroup=jsFunctionName,jsMethod,jsComputed
syntax keyword jsYield yield skipwhite skipempty nextgroup=@jsExpression,jsYieldAsterisk
syntax match   jsYieldAsterisk +\*+ contained skipwhite skipempty nextgroup=@jsExpression

" Function Call
" Matches: func(), obj.func(), obj.func?.(), obj.func<Array<number | string>>() etc.
syntax match   jsFunctionCall +\<\K\k*\>\%(\_s*<\%(\_[^&|]\{-1,}\%([&|]\_[^&|]\{-1,}\)*\)>\)\?\%(\_s*\%(?\.\)\?\_s*(\)\@=+ contains=jsImport,jsSuper,jsFlowGenericCall skipwhite skipempty nextgroup=jsOptionalOperator,jsFunctionCallArgs
syntax region  jsFunctionCallArgs matchgroup=jsFunctionParens start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread,@jsOperators skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallArgs,jsDot,jsOptionalOperator,@jsOperators

" Loops
syntax keyword jsFor for skipwhite skipempty nextgroup=jsLoopCondition
syntax keyword jsOf of contained skipwhite skipempty nextgroup=@jsExpression
syntax region  jsLoopCondition matchgroup=jsLoopParens start=+(+ end=+)+ contained contains=@jsExpression,jsOf,jsVariableType,jsSemicolon,jsComma,@jsOperators skipwhite skipempty nextgroup=jsLoopBlock
syntax region  jsLoopBlock matchgroup=jsLoopBraces start=+{+ end=+}+ contained contains=@jsTop skipwhite skipempty nextgroup=jsWhile

syntax keyword jsDo do skipwhite skipempty nextgroup=jsLoopBlock
syntax keyword jsWhile while skipwhite skipempty nextgroup=jsLoopCondition

syntax keyword jsBreak break skipwhite skipempty nextgroup=jsLabelText
syntax keyword jsContinue continue skipwhite skipempty nextgroup=jsLabelText

syntax match   jsLabel +\<\K\k*\>\_s*:+ contains=jsLabelText skipwhite skipempty nextgroup=jsBlock,jsFor,jsDo,jsWhile
syntax match   jsLabelText +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsLabelColon
syntax match   jsLabelColon +:+ contained

" Control flow
" If statement
syntax keyword jsIf if skipwhite skipempty nextgroup=jsIfCondition,jsIfBlock
syntax keyword jsElse else contained skipwhite skipempty nextgroup=jsIf,jsIfBlock
syntax region  jsIfCondition matchgroup=jsIfParens start=+(+ end=+)+ contained contains=@jsExpression,jsVariableType,jsComma,@jsOperators skipwhite skipempty nextgroup=jsIfBlock
syntax region  jsIfBlock matchgroup=jsIfBraces start=+{+ end=+}+ contained contains=@jsTop skipwhite skipempty nextgroup=jsElse

" Switch statements
syntax keyword jsSwitch switch skipwhite skipempty nextgroup=jsSwitchCondition
syntax region  jsSwitchCondition matchgroup=jsSwitchParens start=+(+ end=+)+ contained contains=@jsExpression,jsVariableType,jsComma,@jsOperators skipwhite skipempty nextgroup=jsSwitchBlock
syntax region  jsSwitchBlock matchgroup=jsSwitchBraces start=+{+ end=+}+ contained contains=jsCaseStatement,@jsTop
syntax region  jsCaseStatement matchgroup=jsSwitchCase start=+\<\(case\|default\)\>+ matchgroup=jsSwitchColon end=+:+ contained contains=@jsExpression keepend

" Exceptions
syntax keyword jsTry try skipwhite skipempty nextgroup=jsExceptionBlock
syntax region  jsExceptionBlock matchgroup=jsExceptionBraces start=+{+ end=+}+ contained contains=@jsTop skipwhite skipempty nextgroup=jsCatch
syntax keyword jsCatch catch skipwhite skipempty nextgroup=jsExceptionBlock,jsExceptionParams,jsFinally
syntax region  jsExceptionParams matchgroup=jsExceptionParens start=+(+ end=+)+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsExceptionBlock
syntax keyword jsFinally finally contained skipwhite skipempty nextgroup=jsExceptionBlock
syntax keyword jsThrow throw skipwhite skipempty nextgroup=@jsExpression

" with statement
syntax keyword jsWith with skipwhite skipempty nextgroup=jsWithExpression
syntax region  jsWithExpression matchgroup=jsWithParens start=+(+ end=+)+ contained contains=@jsExpression,jsVariableType,jsComma,@jsOperators skipwhite skipempty nextgroup=jsBlock

" Tokens that appear at the top-level
syntax cluster jsTop contains=jsDebugger,jsSemicolon,jsParensError,jsBlock,jsParen,jsUnaryOperator,jsOperator,jsImport,jsExport,jsRegexp,jsComment,jsVariableType,jsIdentifier,jsString,jsTemplateString,jsTemplateStringTag,jsNumber,jsArray,jsClass,jsNew,jsDecorator,jsDecoratorName,jsAsync,jsAwait,jsReturn,jsFunction,jsYield,jsFunctionCall,jsFor,jsDo,jsWhile,jsBreak,jsContinue,jsLabel,jsIf,jsSwitch,jsTry,jsThrow,jsWith
" Tokens that produce a value
syntax cluster jsExpression contains=jsRegexp,jsComment,jsString,jsTemplateString,jsNumber,jsArray,jsObject,jsIdentifier,jsAsync,jsAwait,jsYield,jsFunction,jsFunctionCall,jsClass,jsParen,jsUnaryOperator,jsNew
" Tokens that are globally used by JavaScript
syntax cluster jsGlobals contains=jsBuiltinValues,jsThis,jsSuper

" Highlight flow syntax
runtime syntax/extras/flow.vim
" Highlight jsodc
runtime syntax/extras/jsdoc.vim

" Basics
highlight default link jsDebugger Error
highlight default link jsSemicolon Operator
highlight default link jsComma Operator
highlight default link jsAssignmentColon Operator
highlight default link jsAssignmentEqual Operator
highlight default link jsPrivateIdentifier Type
highlight default link jsSpread Operator
highlight default link jsParensError Error
highlight default link jsBraces Special
highlight default link jsParens Special
highlight default link jsBrackets Special

" Operators
highlight default link jsUnaryOperator Keyword
highlight default link jsRelationalOperator Keyword
highlight default link jsOperator Operator
highlight default link jsTernaryOperator jsOperator
highlight default link jsDot jsOperator
highlight default link jsOptionalOperator jsOperator

" Modules
highlight default link jsImport PreProc
highlight default link jsExport jsImport
highlight default link jsFrom jsImport
highlight default link jsModuleDefault Keyword
highlight default link jsModuleAsterisk jsOperator
highlight default link jsModuleAs jsImport
highlight default link jsModuleName jsIdentifier
highlight default link jsModuleComma jsComma
highlight default link jsModuleBraces jsBraces

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
highlight default link jsRegexpCharClass Keyword
highlight default link jsRegexpUnicodeBraces Special
highlight default link jsRegexpUnicodeName Keyword
highlight default link jsRegexpUnicodeEqual Special
highlight default link jsRegexpUnicodeValue Constant
highlight default link jsRegexpGroupParens Special
highlight default link jsRegexpGroupReference Keyword
highlight default link jsRegexpRangeBrackets Special
highlight default link jsRegexpAssertionParens Special

" Comments
highlight default link jsComment Comment
highlight default link jsHashbangComment PreProc
highlight default link jsCommentTodo Todo

" Declaration
highlight default link jsVariableType Type

" Strings and Values
highlight default link jsString String
highlight default link jsTemplateStringTag Identifier
highlight default link jsTemplateString String
highlight default link jsTemplateBrace Keyword
highlight default link jsBuiltinValues Constant
highlight default link jsNumber Number
highlight default link jsNumberDot Special
highlight default link jsNumberSeparator Number

" Object
highlight default link jsObjectBraces jsBraces
highlight default link jsObjectKey Identifier
highlight default link jsObjectKeyString String
highlight default link jsAccessorBrackets jsBrackets

" Destructuring
highlight default link jsDestructuringBrackets jsBrackets
highlight default link jsDestructuringBraces jsBraces
highlight default link jsObjectDestructuringColon Operator

" Class
highlight default link jsClass Keyword
highlight default link jsExtends Keyword
highlight default link jsConstructor Keyword
highlight default link jsSuper Keyword
highlight default link jsStatic Keyword
highlight default link jsClassName Identifier
highlight default link jsClassProp Identifier
highlight default link jsClassPrivate Type
highlight default link jsClassBraces jsBraces
highlight default link jsNew Keyword
highlight default link jsNewClassName Identifier
highlight default link jsNewClassParens jsParens
highlight default link jsNewDot jsDot

" Decorator
highlight default link jsDecorator Keyword
highlight default link jsDecoratorName Type
highlight default link jsDecoratorBraces jsBraces
highlight default link jsDecoratorParens jsParens

" Function
highlight default link jsAsync Keyword
highlight default link jsAwait Keyword
highlight default link jsYield Keyword
highlight default link jsThis Keyword
highlight default link jsReturn Keyword
highlight default link jsFunction Keyword
highlight default link jsFunctionName Function
highlight default link jsFunctionParens jsParens
highlight default link jsFunctionBraces jsBraces
highlight default link jsArrow Keyword
highlight default link jsMethodType Type
highlight default link jsMethod jsFunctionName

highlight default link jsComputedBrackets jsBrackets

" Generator
highlight default link jsGeneratorAsterisk jsOperator
highlight default link jsYieldAsterisk jsOperator

" Function call
highlight default link jsFunctionCall Identifier

" Loops
highlight default link jsFor Keyword
highlight default link jsOf Keyword
highlight default link jsDo Keyword
highlight default link jsWhile Keyword
highlight default link jsLoopParens jsParens
highlight default link jsLoopBraces jsBraces
highlight default link jsLabelText Identifier
highlight default link jsLabelColon jsOperator
highlight default link jsBreak Keyword
highlight default link jsContinue Keyword

" Conditional Statements
highlight default link jsIf Keyword
highlight default link jsElse Keyword
highlight default link jsIfParens jsParens
highlight default link jsIfBraces jsBraces
highlight default link jsSwitch Keyword
highlight default link jsSwitchParens jsParens
highlight default link jsSwitchBraces jsBraces
highlight default link jsSwitchCase Keyword
highlight default link jsSwitchColon jsOperator

" Exceptions
highlight default link jsTry Keyword
highlight default link jsCatch Keyword
highlight default link jsFinally Keyword
highlight default link jsThrow Keyword
highlight default link jsExceptionParens jsParens
highlight default link jsExceptionBraces jsBraces

" with statement
highlight default link jsWith Keyword
highlight default link jsWithParens jsParens

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
