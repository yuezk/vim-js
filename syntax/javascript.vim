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
syntax match   jsComma +,+
syntax match   jsColonAssignment +:+ contained skipwhite skipempty nextgroup=@jsExpression
syntax match   jsAssignmentEqual +=+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsPrivateIdentifier +#+ nextgroup=jsIdentifier,jsFunctionCall
syntax match   jsDot +\.+ skipwhite skipempty nextgroup=jsPrivateIdentifier,jsIdentifier,jsFunctionCall
syntax match   jsSpread +\.\.\.+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsParensError +[)}\]]+

" Operators
" REFERENCE: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators
syntax keyword jsUnaryOperator delete void typeof skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsRelationalOperator in instanceof skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperatorArithmetic +\([+*-]\{1,2}\|%\|/\ze[^/*]\)+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperatorComparison +\([=!]==\?\|[<>]=\?\)+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperatorBit +\([&^|~]\|<<\|>>>\?\)+ skipwhite skipempty nextgroup=@jsExpression
syntax match   jsOperatorLogical +\(!\|[|&]\{2}\)+ skipwhite skipempty nextgroup=@jsExpression
" " *=/=%=+=-=<<=>>=>>>=&=^=|=**=
syntax match   jsOperatorAssignment +\([-/%+&|^]\|<<\|>>>\?\|\*\*\?\)=+ skipwhite skipempty nextgroup=@jsExpression
syntax region  jsTernary matchgroup=jsTernaryOperator start=+?+ end=+:+ contained contains=@jsExpression skipwhite skipempty nextgroup=@jsExpression

syntax match   jsOptionalOperator +?\.+ contained skipwhite skipempty nextgroup=jsIdentifier,jsAccessor,jsFunctionCall,jsFunctionCallArgs 
syntax match   jsOperatorNullish +??+ contained skipwhite skipwhite nextgroup=@jsExpression

syntax cluster jsOperators contains=jsRelationalOperator,jsTernary,jsOperator.*

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
syntax region  jsModuleBlock matchgroup=jsModuleBrace start=+{+ end=+}+ contained contains=jsModuleName,jsModuleComma,jsComment,jsDecoratorName skipwhite skipempty nextgroup=jsFrom
syntax match   jsModuleName +\<\K\k*\>+ contained contains=jsModuleDefault skipwhite skipempty nextgroup=jsFrom,jsModuleComma,jsModuleAs
syntax match   jsModuleComma +,+ contained skipwhite skipempty nextgroup=jsModuleBlock,jsModuleName,jsModuleAsterisk

" Syntax groups for flow module
syntax keyword jsFlowModuleType type contained skipwhite skipempty nextgroup=jsFlowModuleTypeName,jsFlowModuleBlock
syntax match   jsFlowModuleTypeName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowModuleComma,jsFrom
syntax match   jsFlowModuleComma +,+ contained skipwhite skipempty nextgroup=jsFlowModuleBlock,jsFlowModuleTypeName
syntax region  jsFlowModuleBlock matchgroup=jsFlowModuleBraces start=+{+ end=+}+ contained contains=jsFlowModuleTypeName,jsFlowModuleComma skipwhite skipempty nextgroup=jsFrom
syntax keyword jsFlowModuleTypeof typeof contained skipwhite skipempty nextgroup=jsModuleName,jsModuleBlock,jsFlowModuleAsterisk
syntax match   jsFlowModuleAsterisk +\*+ contained skipwhite skipempty nextgroup=jsFlowModuleAs
syntax keyword jsFlowModuleAs as contained skipwhite skipempty nextgroup=jsFlowModuleTypeName

" RegExp
syntax region  jsRegexp matchgroup=jsRegexpSlashes start=+/+ skip=+\\/+ end=+/+ contains=@jsRegexpTokens,jsRegexpError nextgroup=jsRegexpFlags
syntax match   jsRegexpFlags +[gimsuy]\++ contained
syntax match   jsRegexpChars +.+ contained
syntax match   jsRegexpError +)+ contained

syntax match   jsRegexpEscape +\\+ contained nextgroup=jsRegexpChars
syntax match   jsRegexpOr +|+ contained
syntax match   jsRegexpQuantifier +[*?+]\|{\d\+\%(,\d*\)\?}+ contained
syntax match   jsRegexpGroupReference +\\[1-9]\d*+ contained
syntax match   jsRegexpRangeHyphen +\[\@1<!-]\@!+ contained
syntax match   jsRegexpRangeCaret +\[\@1<=\^+ contained
syntax match   jsRegexpDot +\.+ contained
syntax match   jsRegexpCharClass +\\[bBdDwWsStrnvf0]\|\\c\u\|\\x\x\{2}\|\\u\x\{4}\|\\u{\x\{4,5}}+ contained
syntax match   jsRegexpBoundaries +[$^]\|\\[Bb]+ contained
syntax region  jsRegexpUnicode matchgroup=jsRegexpUnicodeBraces start=+\\p{+ end=+}+ contained contains=jsRegexpUnicodeName
syntax match   jsRegexpUnicodeName +\K\k*+ contained nextgroup=jsRegexpUnicodeEqual
syntax match   jsRegexpUnicodeEqual +=+ contained nextgroup=jsRegexpUnicodeValue
syntax match   jsRegexpUnicodeValue +\K\k*+ contained

syntax region  jsRegexpGroup matchgroup=jsRegexpGroupParens start=+(\%(?\%(:\|<\K\k*>\)\)\?+ end=+)+ contained contains=@jsRegexpTokens
syntax region  jsRegexpRange matchgroup=jsRegexpRangeBrackets start=+\[+ end=+]+ contained contains=jsRegexpChars,jsRegexpCharClass,jsRegexpRangeHyphen,jsRegexpRangeCaret
syntax region  jsRegexpAssertion matchgroup=jsRegexpAssertionParens start=+(?<\?[=!]+ end=+)+ contained contains=@jsRegexpTokens

syntax cluster jsRegexpTokens contains=jsRegexpChars,jsRegexpGroup,jsRegexpGroupReference,jsRegexpOr,jsRegexpRange,jsRegexpAssertion,jsRegexpBoundaries,jsRegexpQuantifier,jsRegexpEscape,jsRegexpDot,jsRegexpCharClass,jsRegexpUnicode

" Comments
" Comments can be treat as a special expression which produce nothing, so
" I added it to the expression cluster
syntax keyword jsCommentTodo contained TODO FIXME XXX TBD
syntax region  jsComment start=+//+ end=/$/ contains=jsCommentTodo,@Spell keepend
syntax region  jsComment start=+/\*+  end=+\*/+ contains=jsCommentTodo,@Spell,jsDocTags fold
syntax region  jsHashbangComment start=+^#!+ end=+$+

" Declaration
syntax keyword jsVariableType const let var skipwhite skipempty nextgroup=jsIdentifier,jsObjectDestructuring,jsArrayDestructuring
syntax match   jsIdentifier +\<\K\k*\>+ contains=@jsGlobalValues,jsTemplateStringTag skipwhite skipempty nextgroup=jsOperatorComparison,jsOperatorAssignment,jsAssignmentEqual,jsArrow,jsAccessor,jsDot,jsOptionalOperator,@jsOperators,jsFlowColon

" Strings
syntax region  jsString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsAccessor,@jsOperators,jsFlowColon
syntax match   jsTemplateStringTag +\<\K\k*\>\(\_s*`\)\@=+ skipwhite skipempty nextgroup=jsTemplateString
syntax region  jsTemplateString start=+`+ skip=+\\`+ end=+`+ contains=jsTemplateExpression,@Spell skipwhite skipempty nextgroup=jsAccessor,@jsOperators,jsFlowColon
syntax region  jsTemplateExpression matchgroup=jsTemplateBrace start=+\\\@1<!${+ end=+}+ contained contains=@jsExpression,@jsOperators

" Built-in values
syntax keyword jsBuiltinValues undefined null NaN true false Infinity Symbol contained

" Numbers
" REFERENCE: http://www.ecma-international.org/ecma-262/10.0/index.html#prod-NumericLiteral
syntax match   jsNumber +\c[+-]\?\%(0b[01]\%(_\?[01]\)*\|0o\o\%(_\?\o\)*\|0x\x\%(_\?\x\)*\|\%(\%(\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\.\%(\d\%(_\?\d\)*\)\?\|\.\d\%(_\?\d\)*\|\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\)\%(e[+-]\?\d\%(_\?\d\)*\)\?\)\)+ contains=jsNumberDot,jsNumberSeparator skipwhite skipempty nextgroup=jsAccessor,@jsOperators,jsFlowColon
syntax match   jsNumberDot +\.+ contained
syntax match   jsNumberSeparator +_+ contained

" Code blocks
syntax region  jsBlock matchgroup=jsBraces start=+{+ end=+}+ contains=TOP extend fold
syntax region  jsParen matchgroup=jsParens start=+(+ end=+)+ contains=@jsExpression,jsComma,jsSpread,@jsOperators extend fold skipwhite skipempty nextgroup=jsArrow,jsFunctionCallArgs,jsAccessor,@jsOperators,jsFlowColon

" Array
syntax region  jsArray matchgroup=jsBrackets start=+\[+ end=+]+ contains=@jsExpression,jsComma,jsSpread skipwhite skipempty nextgroup=jsAccessor,@jsOperators,jsFlowColon

" Object
syntax region  jsObject matchgroup=jsObjectBrace start=+{+ end=+}+ contained contains=jsComment,jsIdentifier,jsObjectKey,jsObjectKeyString,jsTemplateString,jsMethod,jsComputed,jsGeneratorAsterisk,jsAsync,jsMethodType,jsComma,jsSpread,jsDot,jsOptionalOperator,@jsOperators,jsObject skipwhite skipempty nextgroup=jsFlowColon
syntax match   jsObjectKey +\<\k\+\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsColonAssignment
syntax region  jsObjectKeyString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contains=@Spell extend skipwhite skipempty nextgroup=jsColonAssignment

" Property accessor, e.g., arr[1] or obj["prop"]
syntax region  jsAccessor matchgroup=jsAccessorBrace start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAccessor,jsFunctionCallArgs,jsOptionalOperator,@jsOperators,jsFlowColon

" Array Destructuring
" Cases like [a, b] = [1, 2] and the array destructuring in the arrow function arguments cannot be highlighted
" as array destructuring, they are highlighted as Array, but it doesn't break the syntax
syntax region  jsArrayDestructuring matchgroup=jsDestructuringBrace start=+\[+ end=+]+ contained contains=jsComment,jsIdentifier,jsComma,jsObjectDestructuring,jsArrayDestructuring,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual,jsFlowColon

" Object Destructuring
" Cases like ({a, b} = {a: 1, b: 2}) and the object destructuring in the arrow function arguments cannot be highlighted
" as object destructuring, they are highlighted as Object, but it doesn't break the syntax
syntax region  jsObjectDestructuring matchgroup=jsDestructuringBrace start=+{+ end=+}+ contained contains=jsComment,jsObjectDestructuringKey,jsIdentifier,jsComma,jsObjectDestructuring,jsArrayDestructuring,jsSpread skipwhite skipempty nextgroup=jsAssignmentEqual,jsFlowColon
syntax match   jsObjectDestructuringKey +\<\K\k*\>\ze\s*:+ contained skipwhite skipempty nextgroup=jsAssignmentEqual,jsObjectDestructuringColon
syntax match   jsObjectDestructuringColon +:+ contained skipwhite skipempty nextgroup=jsIdentifier,jsObjectDestructuring,jsArrayDestructuring

" Class
syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassName,jsClassBody
syntax keyword jsExtends extends contained skipwhite skipempty nextgroup=jsClassName
syntax keyword jsConstructor constructor contained
syntax keyword jsSuper super contained
syntax keyword jsStatic static contained skipwhite skipempty nextgroup=jsClassProp,jsMethod
syntax match   jsClassName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsExtends,jsClassBody,jsFlowGenericDeclare,jsFlowImplments
syntax region  jsClassBody matchgroup=jsClassBrace start=+{+ end=+}+ contained contains=jsComment,jsAsync,jsStatic,jsMethodType,jsClassPrivate,jsClassProp,jsMethod,jsFunctionArgs,jsGeneratorAsterisk,jsComputed,jsDot,jsOptionalOperator,@jsOperators,jsDecoratorName,jsDecoratorParams extend fold
syntax match   jsClassProp +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsAssignmentEqual,jsFlowColon
syntax match   jsClassPrivate +#+ contained nextgroup=jsClassProp,jsMethod

syntax keyword jsNew new skipwhite skipempty nextgroup=jsClassNew
syntax match   jsClassNew +\K\k*\%(\.\K\k*\)*+ contained contains=jsNewDot skipwhite skipempty nextgroup=jsClassNewArgs,jsFlowGenericCall
syntax region  jsClassNewArgs matchgroup=jsClassNewBrace start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread,@jsOperators skipwhite skipempty nextgroup=jsFunctionCallArgs,jsAccessor,jsOptionalOperator,@jsOperators
syntax match   jsNewDot +\.+ contained

" Decorator
" REFERENCE: https://github.com/tc39/proposal-decorators
syntax keyword jsDecorator decorator skipwhite skipempty nextgroup=jsDecoratorName
syntax match   jsDecoratorName +@\K\k*+ skipwhite skipempty nextgroup=jsDecoratorBlock,jsDecoratorParams,jsFrom
syntax region  jsDecoratorParams matchgroup=jsDecoratorParens start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread,@jsOperators nextgroup=jsDecoratorBlock
syntax region  jsDecoratorBlock matchgroup=jsDecoratorBraces start=+{+ end=+}+ contained contains=jsDecoratorName,jsDecoratorParams

" Function
syntax keyword jsAsync async skipwhite skipempty nextgroup=jsFunction,jsFunctionArgs,jsGeneratorAsterisk,jsComputed
syntax keyword jsAwait await skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsThis this contained
syntax keyword jsReturn return skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsFunction function skipwhite skipempty nextgroup=jsGeneratorAsterisk,jsFunctionName,jsFunctionArgs
syntax match   jsFunctionName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFunctionArgs,jsFlowGenericDeclare
syntax region  jsFunctionArgs matchgroup=jsFunctionArgsBrace start=+(+ end=+)+ contained contains=jsComment,jsIdentifier,jsComma,jsSpread,jsObjectDestructuring,jsArrayDestructuring,@jsOperators skipwhite skipempty nextgroup=jsArrow,jsFunctionBody,jsFlowColon fold
syntax region  jsFunctionBody matchgroup=jsFunctionBodyBrace start=+{+ end=+}+ contained contains=TOP extend fold

" Arrow Function
syntax match   jsArrow +=>+ contained skipwhite skipempty nextgroup=@jsExpression,jsFunctionBody

" Object method
syntax match   jsMethod +\<\K\k*\>\(\_s*(\)\@=+ contains=jsConstructor skipwhite skipempty nextgroup=jsFunctionArgs
syntax match   jsMethodType +\<[sg]et\>+ contained skipwhite skipempty nextgroup=jsMethod

" Computed property
syntax region  jsComputed matchgroup=jsComputedBrace start=+\[+ end=+]+ contained contains=@jsExpression skipwhite skipempty nextgroup=jsAssignmentEqual,jsFunctionArgs,jsColonAssignment

" Generator
syntax match   jsGeneratorAsterisk +\*+ contained skipwhite skipempty nextgroup=jsFunctionName,jsMethod,jsComputed
syntax match   jsYieldAsterisk +\*+ contained skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsYield yield skipwhite skipempty nextgroup=@jsExpression,jsYieldAsterisk

" Function Call
" Matches: func(), obj.func(), obj.func?.(), obj.func<Array<number | string>>() etc.
syntax match   jsFunctionCall +\<\K\k*\>\%(\_s*<\%(\_[^&|]\{-1,}\%([&|]\_[^&|]\{-1,}\)*\)>\)\?\%(\_s*\%(?\.\)\?\_s*(\)\@=+ contains=jsImport,jsSuper,jsFlowGenericCall skipwhite skipempty nextgroup=jsOptionalOperator,jsFunctionCallArgs
syntax region  jsFunctionCallArgs matchgroup=jsFunctionCallBrace start=+(+ end=+)+ contained contains=@jsExpression,jsComma,jsSpread,@jsOperators skipwhite skipempty nextgroup=jsFunctionCallArgs,jsAccessor,jsOptionalOperator,@jsOperators

" Loops
syntax keyword jsFor for skipwhite skipempty nextgroup=jsLoopCondition
syntax keyword jsOf of skipwhite skipempty nextgroup=@jsExpression
syntax region  jsLoopCondition matchgroup=jsLoopConditionBrace start=+(+ end=+)+ contained contains=@jsExpression,jsOf,jsVariableType,jsSemicolon,@jsOperators skipwhite skipempty nextgroup=jsLoopBlock
syntax region  jsLoopBlock matchgroup=jsLoopBrace start=+{+ end=+}+ contained contains=TOP skipwhite skipempty nextgroup=jsWhile

syntax keyword jsDo do skipwhite skipempty nextgroup=jsLoopBlock
syntax keyword jsWhile while skipwhite skipempty nextgroup=jsLoopCondition

syntax keyword jsBreak break skipwhite skipempty nextgroup=jsLabelText
syntax keyword jsContinue continue skipwhite skipempty nextgroup=jsLabelText

syntax match   jsLabel +\<\K\k*\>\_s*:+ contains=jsLabelText skipwhite skipempty nextgroup=jsBlock,jsFor,jsDo,jsWhile
syntax match   jsLabelText +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsLabelColon
syntax match   jsLabelColon +:+ contained

" Control flow
" If statements
syntax keyword jsIf if skipwhite skipempty nextgroup=jsCondition,jsConditionalBlock
syntax keyword jsElse else skipwhite skipempty nextgroup=jsIf,jsConditionalBlock
syntax region  jsCondition matchgroup=jsConditionBrace start=+(+ end=+)+ contained contains=@jsExpression,@jsOperators skipwhite skipempty nextgroup=jsConditionalBlock
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
syntax region  jsWithParen matchgroup=jsWithBrace start=+(+ end=+)+ contained contains=@jsExpression,@jsOperators skipwhite skipempty nextgroup=jsBlock

syntax cluster jsGlobalValues contains=jsBuiltinValues,jsThis,jsSuper
syntax cluster jsExpression contains=jsRegexp,jsComment,jsString,jsTemplateString,jsNumber,jsArray,jsObject,jsIdentifier,jsAsync,jsAwait,jsYield,jsFunction,jsFunctionCall,jsClass,jsParen,jsUnaryOperator,jsNew
syntax cluster jsTop contains=TOP

" Flow syntax highlighting
syntax match   jsFlowColon +?\?:+ contained skipwhite skipempty nextgroup=@jsFlowTypes,jsFlowMaybe,jsFlowArrayShorthand,jsFlowChecks,jsFlowGenericContained
syntax match   jsFlowMaybe +?+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowUnion +|+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowIntersection +&+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowChecks +%checks+ contained skipwhite skipempty nextgroup=jsFunctionBody
syntax match   jsFlowArrow +=>+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowModifier +[+-]+ contained skipwhite skipempty nextgroup=jsFlowKey,jsFlowIndexer
syntax keyword jsFlowTypeof typeof contained skipwhite skipempty nextgroup=@jsExpression

" Tokens that can appear after a flow type
syntax cluster jsFlowTokensAfterType contains=jsAssignmentEqual,jsFlowUnion,jsFlowIntersection,jsFlowArrow

syntax match   jsFlowType +\<\K\k*\>+ contained contains=jsFlowPrimitives,jsFlowSpecialType,jsFlowUtility skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFunctionBody,jsArrow,jsFlowGenericContained,jsFlowArrayShorthand,jsFlowChecks,jsFlowColon
syntax keyword jsFlowPrimitives boolean Boolean number Number string String null void contained
syntax keyword jsFlowSpecialType mixed any Object Function contained
syntax match   jsFlowUtility +$\K\k*+ contained

syntax keyword jsFlowBoolean true false contained skipwhite skipempty nextgroup=@jsFlowTokensAfterType
syntax region  jsFlowString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contained skipwhite skipempty nextgroup=@jsFlowTokensAfterType
syntax match   jsFlowNumber +\c-\?\%(0b[01]\%(_\?[01]\)*\|0o\o\%(_\?\o\)*\|0x\x\%(_\?\x\)*\|\%(\%(\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\.\%(\d\%(_\?\d\)*\)\?\|\.\d\%(_\?\d\)*\|\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\)\%(e[+-]\?\d\%(_\?\d\)*\)\?\)\)+ contained contains=jsNumberDot,jsNumberSeparator skipwhite skipempty nextgroup=@jsFlowTokensAfterType

" Generic used after function name or class name
syntax region  jsFlowGenericDeclare matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe,jsComma skipwhite skipempty nextgroup=jsFunctionArgs,jsClassBody,jsExtends,jsFlowImplments
" Generic used after new Class or function call
syntax region  jsFlowGenericCall matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe,jsComma skipwhite skipempty nextgroup=jsClassNewArgs
" Generic used elsewhere
syntax region  jsFlowGenericContained matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe,jsComma,jsFlowGenericContained skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowParen,jsFlowChecks

syntax keyword jsFlowArray Array contained skipwhite skipempty nextgroup=jsFlowGenericContained
syntax match   jsFlowArrayShorthand contained +\[\_s*]+ skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowChecks
syntax region  jsFlowTuple matchgroup=jsFlowBrackets start=+\[+ end=+]+ contained contains=jsComma,@jsFlowTypes skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowChecks

syntax region  jsFlowObject matchgroup=jsFlowBraces start=+{|\?+ end=+|\?}+ contained contains=jsFlowModifier,jsFlowKey,jsComma,jsSemicolon,@jsFlowTypes,jsFlowIndexer,jsComment,jsFlowSpread skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowChecks
syntax match   jsFlowKey +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowColon,jsFlowGenericContained,jsFlowParen
syntax region  jsFlowIndexer matchgroup=jsFlowBrackets start=+\[+ end=+]+ contained contains=jsFlowIndexerKey,@jsFlowTypes skipwhite skipempty nextgroup=jsFlowColon
syntax match   jsFlowIndexerKey +\<\K\k*\>\ze\s*?\?:+ contained skipwhite skipempty nextgroup=jsFlowColon
syntax match   jsFlowSpread +\.\.\.+ contained skipwhite skipempty nextgroup=jsFlowType

syntax region  jsFlowParen matchgroup=jsFlowParens start=+(+ end=+)+ contained contains=jsFlowMaybe,@jsFlowTypes,jsFlowParameter,jsSpread skipwhite skipempty nextgroup=jsFlowArrayShorthand,jsFlowArrow,jsFlowColon
syntax match   jsFlowParameter +\<\K\k*\>\ze\s*?\?:+ contained skipwhite skipempty nextgroup=jsFlowColon

syntax keyword jsFlowDeclare declare skipwhite skipempty nextgroup=jsFlowModuleDeclare
syntax keyword jsFlowModuleDeclare module contained skipwhite skipempty nextgroup=jsFlowModuleName
syntax region  jsFlowModuleName start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contained skipwhite skipempty nextgroup=jsFlowModuleBody
syntax region  jsFlowModuleBody matchgroup=jsFlowBraces start=+{+ end=+}+ contained contains=TOP

syntax keyword jsFlowOpaque opaque skipwhite skipempty nextgroup=jsFlowAliasType
syntax keyword jsFlowAliasType type skipwhite skipempty nextgroup=jsFlowAliasName
syntax match   jsFlowAliasName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowAliasEqual,jsFlowGenericAlias,jsFlowAliasSubtyping
syntax region  jsFlowGenericAlias matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe skipwhite skipempty nextgroup=jsFlowAliasEqual,jsFlowAliasSubtyping
syntax region  jsFlowAliasSubtyping matchgroup=jsFlowColon start=+:+ matchgroup=jsFlowAliasEqual end=+=+ end=+\ze\%(;\|$\)+ contained contains=@jsFlowTypes skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowAliasEqual +=+ contained skipwhite skipempty nextgroup=@jsFlowTypes,jsFlowUnion,jsFlowIntersection,jsFlowMaybe,jsFlowGenericContained

syntax keyword jsFlowInterface interface skipwhite skipempty nextgroup=jsFlowInterfaceName,jsFlowGenericInterface
syntax match   jsFlowInterfaceName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowInterfaceBody,jsFlowGenericInterface
syntax region  jsFlowGenericInterface matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe skipwhite skipempty nextgroup=jsFlowInterfaceBody
syntax region  jsFlowInterfaceBody matchgroup=jsFlowBraces start=+{+ end=+}+ contained contains=jsFlowKey,jsFlowIndexer,jsFlowGenericContained,jsSemicolon,jsComment,jsFlowModifier

syntax keyword jsFlowImplments implements contained skipwhite skipempty nextgroup=jsFlowImplmentsName
syntax match   jsFlowImplmentsName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowImplmentsComma,jsClassBody
syntax match   jsFlowImplmentsComma +,+ contained skipwhite skipempty nextgroup=jsFlowImplmentsName

syntax region  jsComment matchgroup=jsFlowComment start=+/\*:+  end=+\*/+ contains=@jsFlowTypes fold
syntax region  jsComment matchgroup=jsFlowComment start=+/\*\%(::\|flow-include\)+  end=+\*/+ contains=@jsFlowTop,jsFlowColon,jsSemicolon,jsFlowParameter fold

syntax cluster jsFlowTop contains=jsFlowDeclare,jsFlowAliasType,jsFlowOpaque,jsFlowInterface
syntax cluster jsFlowTypes contains=jsFlowType,jsFlowBoolean,jsFlowString,jsFlowNumber,jsFlowObject,jsFlowArray,jsFlowTuple,jsFlowParen,jsFlowTypeof

" JSDoc
syntax match   jsDocTags +@\%(abstract\|virtual\|async\|classdesc\|description\|desc\|file\|fileoverview\|overview\|generator\|global\|hideconstructor\|ignore\|inheritdoc\|inner\|instance\|overide\)\>+ contained
syntax match   jsDocTags +@access\>+ contained skipwhite skipempty nextgroup=jsDocAccessTypes
syntax keyword jsDocAccessTypes package private protected public

syntax match   jsDocTags +@\%(alias\|augments\|extends\|borrows\|callback\|external\|host\|lends\|memberof!\?\|mixes\|name\)+ contained skipwhite skipempty nextgroup=jsDocNamepath
syntax match   jsDocNamepath +\S\++ contained skipwhite skipempty nextgroup=jsDocAs
syntax keyword jsDocAs as contained skipwhite skipempty nextgroup=jsDocNamepath

syntax match   jsDocTags +@author\>+ contained skipwhite skipempty nextgroup=jsDocAuthorName
syntax match   jsDocAuthorName +[^<>]\++ contained skipwhite skipempty nextgroup=jsDocAuthorMail
syntax region  jsDocAuthorMail matchgroup=jsDocAngleBrackets start=+<+ end=+>+ contained

syntax match   jsDocTags +@\%(class\|constructor\|constant\|const\|enum\|implements\|member\|var\|package\)\>+ skipwhite skipempty nextgroup=jsDocTypeBlock
syntax match   jsDocTags +@\%(constructs\|function\|func\|method\|interface\|mixin\)\>+ skipwhite skipempty nextgroup=jsDocIdentifer

syntax match   jsDocTags +@\%(copyright\|deprecated\|license\)\>+ skipwhite skipempty nextgroup=jsDocImportant
syntax match   jsDocImportant +.\++ contained

syntax match   jsDocTags +@\%(default\|defaultValue\)\>+ contained skipwhite nextgroup=jsDocValue
syntax match   jsDocValue +.\++ contained

syntax match   jsDocTags +@\%(event\|fires\|emits\|listens\)\>+ contained skipwhite nextgroup=jsDocEvent
syntax match   jsDocEvent +\S\++ contained

syntax match   jsDocTags +@example\>+ contained skipwhite skipempty nextgroup=,jsDocExample,jsDocCaption
syntax region  jsDocCaption matchgroup=jsDocCaptionTag start=+<caption>+ end=+</caption>+ contained skipwhite skipempty nextgroup=jsDocExample

syntax match   jsDocTags +@exports\>+ contained skipwhite nextgroup=jsDocModuleName
syntax match   jsDocModuleName +\%(\<module:\)\?\K\k*\%(/\K\k*\)*+ contained

syntax match   jsDocTags +@kind\>+ contained skipwhite nextgroup=jsDocKinds
syntax keyword jsDocKinds class constant event external file function member mixin module namespace typedef contained

syntax match   jsDocTags +@\%(module\|namespace\)\>+ contained skipwhite nextgroup=jsDocTypeBlock,jsDocIdentifer

syntax region  jsDocExample matchgroup=jsDocExampleBoundary start=+\*\%([*/]\|\s*@\)\@!+ end=+$+ contained contains=@jsTop keepend skipwhite skipempty nextgroup=jsDocExample

syntax region  jsDocTypeBlock matchgroup=jsDocBraces start=+{+ end=+}+ contained keepend contains=jsDocType skipwhite nextgroup=jsDocIdentifer
syntax match   jsDocType +\S\++ contained
syntax match   jsDocIdentifer +\<\K\k*\>+ contained

syntax cluster jsDocTags contains=jsDocTagDirectives

highlight default link jsDocBraces Special
highlight default link jsDocTags PreProc
highlight default link jsDocAccessTypes Keyword
highlight default link jsDocAuthorName Keyword
highlight default link jsDocAuthorMail Keyword
highlight default link jsDocImportant Keyword
highlight default link jsDocValue Constant
highlight default link jsDocCaptionTag Type
highlight default link jsDocKinds Keyword
highlight default link jsDocExampleBoundary jsComment

highlight default link jsDocAngleBrackets Special

highlight default link jsDocAs Keyword
highlight default link jsDocType Type

" Operators
highlight default link jsUnaryOperator Keyword
highlight default link jsOperatorArithmetic Operator
highlight default link jsOperatorComparison Operator
highlight default link jsOperatorBit Operator
highlight default link jsOperatorLogical Operator
highlight default link jsOperatorConditional Operator
highlight default link jsOperatorAssignment Operator
highlight default link jsTernaryOperator Operator

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

" Flow syntax
highlight default link jsFlowColon Operator
highlight default link jsFlowMaybe Operator
highlight default link jsFlowUnion Operator
highlight default link jsFlowIntersection Operator

highlight default link jsFlowType Type
highlight default link jsFlowPrimitives Keyword
highlight default link jsFlowSpecialType Type
highlight default link jsFlowUtility Keyword
highlight default link jsFlowBoolean Constant
highlight default link jsFlowString String
highlight default link jsFlowNumber Number

highlight default link jsFlowKey Identifier
highlight default link jsFlowSpread Special
highlight default link jsFlowIndexerKey Identifier
highlight default link jsFlowArray Type
highlight default link jsFlowArrayShorthand Special
highlight default link jsFlowAngleBrackets Special
highlight default link jsFlowBrackets Special
highlight default link jsFlowBraces Special
highlight default link jsFlowParens Special
highlight default link jsFlowArrow Special
highlight default link jsFlowChecks Special
highlight default link jsFlowTypeof Keyword

highlight default link jsFlowDeclare Keyword
highlight default link jsFlowModuleDeclare Keyword
highlight default link jsFlowModuleName String
highlight default link jsFlowOpaque Keyword
highlight default link jsFlowAliasType Keyword
highlight default link jsFlowAliasName Type
highlight default link jsFlowAliasEqual Operator

highlight default link jsFlowInterface Keyword
highlight default link jsFlowInterfaceName Type
highlight default link jsFlowImplments Keyword
highlight default link jsFlowImplmentsName Type
highlight default link jsFlowImplmentsComma Operator
highlight default link jsFlowModifier Operator

highlight default link jsFlowModuleType Keyword
highlight default link jsFlowModuleTypeName Type
highlight default link jsFlowModuleComma jsComma
highlight default link jsFlowModuleBraces jsModuleBrace
highlight default link jsFlowModuleTypeof Keyword
highlight default link jsFlowModuleAsterisk Operator
highlight default link jsFlowModuleAs Keyword
highlight default link jsFlowComment Comment

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
