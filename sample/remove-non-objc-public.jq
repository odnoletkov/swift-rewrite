# TODO: @objc could be not the first attribute
(
  ..
  | select(.kind? // empty | in({}|{TypealiasDecl,AssociatedtypeDecl,ClassDecl,StructDecl,ProtocolDecl,ExtensionDecl,FunctionDecl,InitializerDecl,DeinitializerDecl,SubscriptDecl,ImportDecl,VariableDecl,EnumCaseDecl,EnumDecl,OperatorDecl,PrecedenceGroupDecl,}))
  | select(.layout[0].layout[0] | [.layout[0,1].tokenKind | .kind, .text] != ["at_sign", null, "identifier", "objc"])
  | .layout[1].layout[]?.layout[0]
  | select(.tokenKind.kind == "kw_public" or .tokenKind.text == "open")
) |= (
  .tokenKind.text = "" | .trailingTrivia = []
)
