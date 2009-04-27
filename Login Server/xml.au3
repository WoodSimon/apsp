;;;;;;;;;;;;;;; ____ ISC SERVER ____ ;;;;;;;;;;;;;;;
;; AUTHOR == JIYAN AKGÜL 						;;;;
;; (C) 2009 BY JIYAN AKGÜL FOR APSP BY EVO-SOFT.;;;;
;; ALL RIGHTS RESERVED.							;;;;
;; LICENSED BY GNU v3  							;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#cs GNU General Public License v3.0

XML read & write UDF
Copyright (C) 2009  Jiyan Akgül

This program is free software
you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program
if not, see <http://www.gnu.org/licenses/>.
#ce

;; GLOBALS
Dim $XML_SOURCE[101]
Global $FILE_


Func _XML_Open( $FILE ,$Flag )
	$XML_SOURCE[0] = $XML_SOURCE[0] + 1
	$ID = $XML_SOURCE[0]
	Switch $Flag
		Case 1
			$FILE_ = FileOpen( $FILE, 0)
			$XML_SOURCE[$ID] = FileRead($FILE_)
			FileClose($FILE_)
		Case 2
			$XML_SOURCE[$ID] = FileOpen($FILE, 1)
	EndSwitch
EndFunc

Func _XML_Set_Base( $Base_Name, $ID = -1 )
	if $ID = -1 then $ID = $XML_SOURCE[0]
	$Base_Index = _StringBetween( $XML_SOURCE[$ID], "<"&$Base_Name&">", "</"&$Base_Name&">" )
	if $Base_Index <> 0 Then
		$XML_SOURCE[$ID] = $Base_Index[0]
		Return $ID
	Else
		Return SetError(0)
	EndIf
EndFunc	

Func _XML_Get_Value( $VALUE,$ID = -1 )
	if $ID = -1 then $ID = $XML_SOURCE[0]
	$VALUE_Index = _StringBetween( $XML_SOURCE[$ID], "<"&$VALUE&">", "</"&$VALUE&">" )
	if $VALUE_Index <> 0 Then
		Return $VALUE_Index[0]
	Else
		Return SetError(5)
	EndIf
EndFunc	

Func _XML_Write( $VALUE, $Text,  $ID = -1 )
	if $ID = -1 then $ID = $XML_SOURCE[0]
	FileWrite( $ID, "<"&$VALUE&">"&$Text&"</"&$VALUE&">"&@CRLF)
EndFunc

Func _XML_Close( $ID = -1 )
	if $ID = -1 then $ID = $XML_SOURCE[0]
	FileClose($ID)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _StringBetween
; Description ...: Returns the string between the start search string and the end search string.
; Syntax.........: _StringBetween($sString, $sStart, $sEnd[, $vCase = -1[, $iSRE = -1]])
; Parameters ....: $sString - The string to search.
;                  $sStart  - The beginning of the string to find
;                  $sEnd    - The end of the string to find
;                  $vCase   - Optional: Case sensitive search. Default or -1 is not Case sensitive else Case sensitive.
;                  $iSRE    - Optional: Toggle for regular string manipulation or StringRegExp search. Default is regular string manipulation.
; Return values .: Success - A 0 based $array[0] contains the first found string.
;                  Failure - 0
;                  |@Error  - 1 = No inbetween string found.
; Author ........: SmOke_N (Thanks to Valik for helping with the new StringRegExp (?s)(?i) isssue)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringBetween($sString, $sStart, $sEnd, $vCase = -1, $iSRE = -1)
	If $iSRE = -1 Or $iSRE = Default Then
		If $vCase = -1 Or $vCase = Default Then
			$vCase = 0
		Else
			$vCase = 1
		EndIf
		Local $sHold = '', $sSnSStart = '', $sSnSEnd = ''
		While StringLen($sString) > 0
			$sSnSStart = StringInStr($sString, $sStart, $vCase)
			If Not $sSnSStart Then ExitLoop
			$sString = StringTrimLeft($sString, ($sSnSStart + StringLen($sStart)) - 1)
			$sSnSEnd = StringInStr($sString, $sEnd, $vCase)
			If Not $sSnSEnd Then ExitLoop
			$sHold &= StringLeft($sString, $sSnSEnd - 1) & Chr(1)
			$sString = StringTrimLeft($sString, $sSnSEnd)
		WEnd
		If Not $sHold Then Return SetError(1, 0, 0)
		$sHold = StringSplit(StringTrimRight($sHold, 1), Chr(1))
		Local $avArray[UBound($sHold) - 1]
		For $iCC = 1 To UBound($sHold) - 1
			$avArray[$iCC - 1] = $sHold[$iCC]
		Next
		Return $avArray
	Else
		If $vCase = Default Or $vCase = -1 Then
			$vCase = '(?i)'
		Else
			$vCase = ''
		EndIf
		Local $aArray = StringRegExp($sString, '(?s)' & $vCase & $sStart & '(.*?)' & $sEnd, 3)
		If IsArray($aArray) Then Return $aArray
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_StringBetween	