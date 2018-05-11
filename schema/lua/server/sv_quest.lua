netstream.Hook( "ChangeQuestVar", function( ply, identifier, varKey, value )

  netstream.Start( nil, "ReceiveQuestVar", identifier, varKey, value );

end );

