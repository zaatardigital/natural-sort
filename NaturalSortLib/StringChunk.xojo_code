#tag Class
Private Class StringChunk
	#tag Method, Flags = &h0
		Function Compare(inRightSide As StringChunk) As Integer
		  If Self.Type = StringChunk.Types.Number And inRightSide.Type = StringChunk.Types.Number Then
		    // The simplest case
		    Return Ctype( Self.Value, Integer ) - Ctype( inRightSide.Value, Integer )
		    
		  Elseif Self.Type = StringChunk.Types.Characters And inRightSide.Type = StringChunk.Types.Characters Then
		    Dim theLeftSide As String = CType( Self.Value, String )
		    Dim theRightSide As String = CType( inRightSide.Value, String )
		    
		    If theLeftSide > theRightSide Then
		      Return 1
		      
		    Elseif theLeftSide < theRightSide Then
		      Return -1
		      
		    Else
		      Return 0
		      
		    End If
		    
		  Else
		    // In a natural comparison, numbers always come first
		    Return If( Self.Type = StringChunk.Types.Characters, 1, -1 ) 
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(inValue As Auto, inType As StringChunk.Types)
		  Value = inValue
		  Self.Type = inType
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Operator_Compare(inRightSide As NaturalSortLib.StringChunk) As Integer
		  Return Self.Compare( inRightSide )
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Type As StringChunk.Types
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As Auto
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Number
		Characters
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
