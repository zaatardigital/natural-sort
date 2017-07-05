#tag Module
Protected Module NaturalSortLib
	#tag Method, Flags = &h1
		Protected Sub ClearNaturalSplitCache()
		  //-- Remove all entries in the split cache
		  
		  If Not ( pNaturalSplitCache Is Nil ) Then
		    pNaturalSplitCache.RemoveAll
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Compare(inLeftString As String, inRightString As String) As Integer
		  // Split both sides in an array of StringChunks
		  Dim theLeftValues() As StringChunk = NaturalSplit( inLeftString )
		  Dim theRightValues() As StringChunk = NaturalSplit( inRightString )
		  
		  // Cache the upper bound index for both arrays
		  Dim theLeftUBound As Integer = theLeftValues.Ubound
		  Dim theRightUBound As Integer = theRightValues.Ubound
		  
		  // Initialize the loop counter
		  Dim i As Integer
		  
		  // Loop until we reach the end of one of the arrays
		  Do Until i > theLeftUBound Or i > theRightUBound
		    
		    // Retrieve the elements and compare them
		    Dim theLeftValue As NaturalSortLib.StringChunk = theLeftValues( i )
		    Dim theRightValue As NaturalSortLib.StringChunk = theRightValues( i )
		    Dim theResult As Integer = theLeftValue.Compare( theRightValue )
		    
		    // If they are different, return the result of the comparison
		    If theResult <> 0 Then Return If( theResult > 0, 1, -1)
		    
		    // Increment the counter
		    i = i + 1
		    
		  Loop
		  
		  // So far the strings appear to be the same for a natural comparison.
		  // Then the shorter is the smallest i.e. the first.
		  // So the difference in the number of parts will give us our comparison result.
		  // And if there is the same number of parts, then the strings are naturally equal. 
		  Return Sign( theLeftValues.Ubound - theRightValues.Ubound )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NaturalSplit(inString As String) As StringChunk()
		  #pragma DisableBoundsChecking
		  
		  Dim theResult() As StringChunk
		  
		  // No need to handle an empty string
		  If inString = "" Then Return theResult
		  
		  // Create the cache if needed
		  If pNaturalSplitCache Is Nil Then
		    pNaturalSplitCache = New Xojo.Core.Dictionary
		    
		  Else
		    // Do we have this string in cache ?
		    If pNaturalSplitCache.HasKey( inString ) Then 
		      // We have it cached, retrieve it
		      Return pNaturalSplitCache.Value( inString )
		      
		    End If
		    
		  End If
		  
		  // No cache entry, build the array from the string
		  // Setup a few variables
		  Dim theBuffer() As String
		  Dim theBufferType As StringChunk.Types
		  Dim theCharCount As Integer = inString.Len
		  
		  // Let's process each character one at a time
		  // The outpout condition for the loop is when there is no more character to process
		  Dim IsFirstCharacter As Boolean = True
		  Dim i As Integer = 1
		  Do
		    // Retrieve the char and its code
		    Dim theChar As String = inString.Mid( i, 1 )
		    Dim theCharCode As Integer = theChar.Asc
		    
		    // Skip control codes ( ie. ASCII code 0-31 )
		    If theCharCode > 31 Then
		      // Determine the character type
		      Dim theCharType As StringChunk.Types = If( theCharCode > 47 And theCharCode < 58, _
		      StringChunk.Types.Number, StringChunk.Types.Characters )
		      
		      // How to handle it?
		      If isFirstCharacter Then
		        // Handle the first real character ( ie. not a control code  )
		        theBuffer.Append theChar
		        theBufferType = theCharType
		        isFirstCharacter = False
		        
		      Elseif theCharType = theBufferType Then
		        // Add the character to the buffer
		        theBuffer.Append theChar
		        
		      Else
		        // the type has changed, store the chunk and its type
		        If theBufferType = StringChunk.Types.Number Then
		          theResult.Append New StringChunk( Val( Join( theBuffer, "" ) ), theBufferType )
		          
		        Else
		          theResult.Append New StringChunk( Join( theBuffer, "" ), theBufferType )
		          
		        End If
		        
		        // Reset the buffer with the new character
		        Redim theBuffer( 0 )
		        theBuffer( 0 ) = theChar
		        theBufferType = theCharType
		        
		      End If
		      
		    End If
		    
		    // Next character
		    i = i + 1
		    
		  Loop Until i > theCharCount 
		  
		  // Add the last buffer if needed
		  If theBuffer.Ubound > -1 Then
		    // Store the chunk
		    If theBufferType = StringChunk.Types.Number Then
		      theResult.Append New StringChunk( Val( Join( theBuffer, "" ) ), theBufferType )
		      
		    Else
		      theResult.Append New StringChunk( Join( theBuffer, "" ), theBufferType )
		      
		    End If
		    
		  End If
		  
		  // Add the entry to the cache
		  // The cache can't be Nil here since it has been created
		  // at the beginning of the method if it was missing
		  pNaturalSplitCache.Value( inString ) = theResult
		  
		  // Return the array
		  Return theResult
		End Function
	#tag EndMethod


	#tag Note, Name = License
		MIT License
		
		Copyright (c) 2017 Za'atar Digital
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
	#tag EndNote


	#tag Property, Flags = &h0
		pNaturalSplitCache As Xojo.Core.Dictionary
	#tag EndProperty


	#tag Constant, Name = CopyrightString, Type = String, Dynamic = False, Default = \"NaturalSortLib v0.1.1 / \xC2\xA9 Eric de La Rochette - July 2017", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VersionBug, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VersionMajor, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VersionMinor, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


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
End Module
#tag EndModule
