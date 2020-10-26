" Flow syntax highlighting
" Syntax groups for flow module
syntax keyword jsFlowModuleType type contained skipwhite skipempty nextgroup=jsFlowModuleTypeName,jsFlowModuleBlock
syntax match   jsFlowModuleTypeName +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowModuleComma,jsFrom
syntax match   jsFlowModuleComma +,+ contained skipwhite skipempty nextgroup=jsFlowModuleBlock,jsFlowModuleTypeName
syntax region  jsFlowModuleBlock matchgroup=jsFlowModuleBraces start=+{+ end=+}+ contained contains=jsFlowModuleTypeName,jsFlowModuleComma skipwhite skipempty nextgroup=jsFrom
syntax keyword jsFlowModuleTypeof typeof contained skipwhite skipempty nextgroup=jsModuleName,jsModuleBlock,jsFlowModuleAsterisk
syntax match   jsFlowModuleAsterisk +\*+ contained skipwhite skipempty nextgroup=jsFlowModuleAs
syntax keyword jsFlowModuleAs as contained skipwhite skipempty nextgroup=jsFlowModuleTypeName

syntax match   jsFlowColon +?\?:+ contained skipwhite skipempty nextgroup=@jsFlowTypes,jsFlowMaybe,jsFlowArrayShorthand,jsFlowChecks,jsFlowGenericContained
syntax match   jsFlowMaybe +?+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowUnion +|+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowIntersection +&+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowChecks +%checks+ contained skipwhite skipempty nextgroup=jsFunctionBody
syntax match   jsFlowArrow +=>+ contained skipwhite skipempty nextgroup=@jsFlowTypes
syntax match   jsFlowModifier +[+-]+ contained skipwhite skipempty nextgroup=jsFlowKey,jsFlowIndexer
syntax keyword jsFlowTypeof typeof contained skipwhite skipempty nextgroup=@jsExpression

" Tokens that can appear after a flow type
syntax cluster jsFlowTokensAfterType contains=jsAssignmentEqual,jsFlowUnion,jsFlowIntersection

syntax match   jsFlowType +\<\K\k*\>+ contained contains=jsFlowPrimitives,jsFlowSpecialType,jsFlowUtility skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFunctionBody,jsArrow,jsFlowGenericContained,jsFlowArrayShorthand,jsFlowChecks,jsFlowColon
syntax keyword jsFlowPrimitives boolean Boolean number Number string String null void contained
syntax keyword jsFlowSpecialType mixed any Object Function contained
syntax match   jsFlowUtility +$\K\k*+ contained

syntax keyword jsFlowBoolean true false contained skipwhite skipempty nextgroup=@jsFlowTokensAfterType
syntax region  jsFlowString start=+\z(["']\)+ skip=+\\\\\|\\\z1\|\\\n+ end=+\z1+ contained skipwhite skipempty nextgroup=@jsFlowTokensAfterType
syntax match   jsFlowNumber +\c-\?\%(0b[01]\%(_\?[01]\)*\|0o\o\%(_\?\o\)*\|0x\x\%(_\?\x\)*\|\%(\%(\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\.\%(\d\%(_\?\d\)*\)\?\|\.\d\%(_\?\d\)*\|\%(0\|[1-9]\%(_\?\d\%(_\?\d\)*\)\?\)\)\%(e[+-]\?\d\%(_\?\d\)*\)\?\)\)+ contained contains=jsNumberDot,jsNumberSeparator skipwhite skipempty nextgroup=@jsFlowTokensAfterType

" Generic used after function name or class name
syntax region  jsFlowGenericDeclare matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe,jsComma skipwhite skipempty nextgroup=jsFunctionArgs,jsClassBody,jsExtends,jsFlowImplments
" Generic used after new Class or function call
syntax region  jsFlowGenericCall matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe,jsComma skipwhite skipempty nextgroup=jsNewClassArgs
" Generic used elsewhere
syntax region  jsFlowGenericContained matchgroup=jsFlowAngleBrackets start=+<+ end=+>+ contained contains=@jsFlowTypes,jsFlowMaybe,jsComma,jsFlowGenericContained skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowParen,jsFlowChecks

syntax keyword jsFlowArray Array contained skipwhite skipempty nextgroup=jsFlowGenericContained
syntax match   jsFlowArrayShorthand contained +\[\_s*]+ skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowChecks
syntax region  jsFlowTuple matchgroup=jsFlowBrackets start=+\[+ end=+]+ contained contains=jsComma,jsComment,@jsFlowTypes skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowChecks

syntax region  jsFlowObject matchgroup=jsFlowBraces start=+{|\?+ end=+|\?}+ contained contains=jsFlowModifier,jsFlowKey,jsComma,jsSemicolon,@jsFlowTypes,jsFlowIndexer,jsComment,jsFlowSpread skipwhite skipempty nextgroup=@jsFlowTokensAfterType,jsFlowChecks
syntax match   jsFlowKey +\<\K\k*\>+ contained skipwhite skipempty nextgroup=jsFlowColon,jsFlowGenericContained,jsFlowParen
syntax region  jsFlowIndexer matchgroup=jsFlowBrackets start=+\[+ end=+]+ contained contains=jsFlowIndexerKey,@jsFlowTypes skipwhite skipempty nextgroup=jsFlowColon
syntax match   jsFlowIndexerKey +\<\K\k*\>\ze\s*?\?:+ contained skipwhite skipempty nextgroup=jsFlowColon
syntax match   jsFlowSpread +\.\.\.+ contained skipwhite skipempty nextgroup=jsFlowType

syntax region  jsFlowParen matchgroup=jsFlowParens start=+(+ end=+)+ contained contains=jsFlowMaybe,@jsFlowTypes,jsFlowParameter,jsSpread,jsComment skipwhite skipempty nextgroup=jsFlowArrayShorthand,jsFlowArrow,jsFlowColon
syntax match   jsFlowParameter +\<\K\k*\>\ze\s*?\?:+ contained skipwhite skipempty nextgroup=jsFlowColon

syntax keyword jsFlowDeclare declare skipwhite skipempty nextgroup=jsFlowModuleDeclare,jsClass,jsFunction,jsVariableType,jsExport
syntax keyword jsFlowModuleDeclare module contained skipwhite skipempty nextgroup=jsFlowModuleName
syntax region  jsFlowModuleName start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contained skipwhite skipempty nextgroup=jsFlowModuleBody
syntax region  jsFlowModuleBody matchgroup=jsFlowBraces start=+{+ end=+}+ contained contains=jsComment,@jsFlowTop

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
syntax cluster jsTop add=@jsFlowTop

" Flow syntax
highlight default link jsFlowColon Operator
highlight default link jsFlowMaybe Operator
highlight default link jsFlowUnion Operator
highlight default link jsFlowIntersection Operator

highlight default link jsFlowType Type
highlight default link jsFlowPrimitives Type
highlight default link jsFlowSpecialType Type
highlight default link jsFlowUtility PreProc
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
highlight default link jsFlowOpaque PreProc
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
