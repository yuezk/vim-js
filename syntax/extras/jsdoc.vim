" JSDoc
syntax match   jsDocTags +@\%(abstract\|virtual\|async\|classdesc\|description\|desc\|file\|fileoverview\|overview\|generator\|global\|hideconstructor\|ignore\|inheritdoc\|inner\|instance\|override\|readonly\|static\|summary\|todo\)\>+ contained
syntax match   jsDocTags +@access\>+ contained skipwhite nextgroup=jsDocAccessTypes
syntax keyword jsDocAccessTypes package private protected public contained

syntax match   jsDocTags +@\%(alias\|augments\|extends\|borrows\|callback\|constructs\|external\|function\|func\|method\|interface\|mixin\|host\|lends\|memberof!\?\|mixes\|name\|this\|tutorial\)+ contained skipwhite nextgroup=jsDocNamepath
syntax match   jsDocNamepath +[^[:blank:]*]\++ contained skipwhite nextgroup=jsDocAs
syntax keyword jsDocAs as contained skipwhite nextgroup=jsDocNamepath

syntax match   jsDocTags +@author\>+ contained skipwhite nextgroup=jsDocAuthorName
syntax match   jsDocAuthorName +[^<>]\++ contained skipwhite nextgroup=jsDocAuthorMail
syntax region  jsDocAuthorMail matchgroup=jsDocAngleBrackets start=+<+ end=+>+ contained

syntax match   jsDocTags +@\%(class\|constructor\|constant\|const\|enum\|implements\|member\|var\|package\|private\|protected\|public\|type\)\>+ contained skipwhite nextgroup=jsDocTypeBlock,jsDocIdentifier

syntax match   jsDocTags +@\%(copyright\|deprecated\|license\|since\|variation\|version\)\>+ contained skipwhite nextgroup=jsDocImportant
syntax match   jsDocImportant +.\++ contained

syntax match   jsDocTags +@\%(default\|defaultValue\)\>+ contained skipwhite nextgroup=jsDocValue
syntax match   jsDocValue +.\++ contained

syntax match   jsDocTags +@\%(event\|fires\|emits\|listens\)\>+ contained skipwhite nextgroup=jsDocEvent
syntax match   jsDocEvent +[^[:blank:]*]\++ contained

syntax match   jsDocTags +@example\>+ contained skipwhite skipempty nextgroup=jsDocExample,jsDocCaption
syntax region  jsDocCaption matchgroup=jsDocCaptionTag start=+<caption>+ end=+</caption>+ contained skipwhite skipempty nextgroup=jsDocExample
syntax region  jsDocExample matchgroup=jsDocExampleBoundary start=+\*\%([*/]\|\s*@\)\@!+ end=+$+ contained contains=TOP keepend skipwhite skipempty nextgroup=jsDocExample

syntax match   jsDocTags +@\%(exports\|requires\)\>+ contained skipwhite nextgroup=jsDocModuleName
syntax match   jsDocModuleName +\%(module:\)\?\K\k*\%([/.#]\K\k*\)*+ contained

syntax match   jsDocTags +@kind\>+ contained skipwhite nextgroup=jsDocKinds
syntax keyword jsDocKinds class constant event external file function member mixin module namespace typedef contained

syntax match   jsDocTags +@\%(module\|namespace\|param\|arg\|argument\|prop\|property\|typedef\)\>+ contained skipwhite nextgroup=jsDocTypeBlock,jsDocModuleName
syntax match   jsDocTags +@\%(returns\|return\|throws\|exception\|yields\|yield\)\>+ contained skipwhite nextgroup=jsDocReturnTypeBlock
syntax match   jsDocTags +@\%(see\)\>+ contained skipwhite nextgroup=jsDocNamepath,jsDocInline

syntax region  jsDocTypeBlock matchgroup=jsDocBraces start=+{+ end=+}+ contained keepend contains=jsDocType skipwhite nextgroup=jsDocIdentifier
syntax region  jsDocReturnTypeBlock matchgroup=jsDocBraces start=+{+ end=+}+ contained keepend contains=jsDocType
syntax match   jsDocType +[^[:blank:]*]\++ contained
syntax match   jsDocIdentifier +\[\?\K\k*\%(\%(\[]\)\?\.\K\k*\)*\%(=[^]]\+\)\?]\?+ contained skipwhite nextgroup=jsDocHyphen
syntax match   jsDocHyphen +-+ contained

syntax region  jsDocInline matchgroup=jsDocBraces start=+{@\@=+ end=+}+ contained contains=jsDocTagsInline keepend
syntax match   jsDocTagsInline +@\%(link\|linkcode\|linkplain\|tutorial\)\>+ contained skipwhite nextgroup=jsDocLinkPath
syntax match   jsDocLinkPath +[^[:blank:]|]\++ contained skipwhite nextgroup=jsDocLinkSeparator
syntax match   jsDocLinkSeparator +[[:blank:]|]+ contained skipwhite nextgroup=jsDocLinkText
syntax match   jsDocLinkText +[^|]\++ contained

highlight default link jsDocBraces Special
highlight default link jsDocTags Keyword
highlight default link jsDocAccessTypes Type
highlight default link jsDocAuthorName String
highlight default link jsDocAuthorMail String
highlight default link jsDocImportant String
highlight default link jsDocValue Constant
highlight default link jsDocCaption String
highlight default link jsDocCaptionTag Type
highlight default link jsDocKinds Keyword
highlight default link jsDocExampleBoundary jsComment
highlight default link jsDocNamepath Identifier
highlight default link jsDocIdentifier Identifier
highlight default link jsDocModuleName Identifier
highlight default link jsDocEvent Identifier

highlight default link jsDocAngleBrackets Special
highlight default link jsDocHyphen Special

highlight default link jsDocTagsInline jsDocTags
highlight default link jsDocLinkPath String
highlight default link jsDocLinkSeparator jsDocBraces
highlight default link jsDocLinkText Identifier

highlight default link jsDocAs Keyword
highlight default link jsDocType Type
