#include-once


;;;;;;;;;;;;;;; ____ PACKET UDF ____ ;;;;;;;;;;;;;;;
;; AUTHOR == JIYAN AKGÜL 						;;;;
;; (C) 2009 BY JIYAN AKGÜL FOR APSP BY EVO-SOFT.;;;;
;; ALL RIGHTS RESERVED.							;;;;
;; LICENSED BY GNU v3  							;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#cs GNU General Public License v3.0 [ ENGLISH ]

Packet UDF for creating and reading HEX packets
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



dim $PACKET[5][999999]
dim $PACK[5][999999]

Global Const $SHORT = 8 ; 4 bytes ( 8 stellen )
Global Const $LONG = 16 ; 8 bytes ( 16 stellen )


;;; ############### FUNC :: msg_clear ######## ;;;
;;; Function Name 	:	msg_clear()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_clear($id=0)
		$PACKET[$id][0] = 0
EndFunc

;;; ############### FUNC :: msg_AddInt ######## ;;;
;;; Function Name 	:	msg_AddInt()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddInt($int,$ishex=0,$islittl=0,$id=0)
		$PACKET[$id][0] = $PACKET[$id][0] + 1
		$i = $PACKET[$id][0]
		if $ishex=0 Then $int = Hex($int)
		if $islittl=0 Then $int = _RotateHex($int)
		$PACKET[$id][$i] = $int
EndFunc

;;; ############### FUNC :: msg_AddString ######## ;;;
;;; Function Name 	:	msg_AddString()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddString($string,$id=0)

		$PACKET[$id][0] = $PACKET[$id][0] + 2
		$i = $PACKET[$id][0]
		$PACKET[$id][$i-1] = _RotateHex(Hex(StringLen($string)))
		$PACKET[$id][$i] = StringReplace(StringToBinary($string),"0x","")
endfunc

;;; ############### FUNC :: msg_AddHex ######## ;;;
;;; Function Name 	:	msg_AddHex()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddHex($hex,$id=0)

		$PACKET[$id][0] = $PACKET[$id][0] + 1
		$i = $PACKET[$id][0]
		$PACKET[$id][$i] = $hex

EndFunc

;;; ############### FUNC :: msg_AddByte ######## ;;;
;;; Function Name 	:	msg_AddByte()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddByte($Byte,$id=0)
		$len = StringLen(StringReplace($byte,"0x",""))
		$PACKET[$id][0] = $PACKET[$id][0] + 1
		$i = $PACKET[$id][0]
		$PACKET[$id][$i] = StringLeft(StringReplace(Binary($Byte),"0x",""),$len)
EndFunc

;;; ############### FUNC :: msg_AddComand ######## ;;;
;;; Function Name 	:	msg_AddComand()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddComand($Byte,$id=0)
		$PACKET[$id][0] = $PACKET[$id][0] + 1
		$i = $PACKET[$id][0]
		$PACKET[$id][$i] = StringReplace(Binary($Byte),"0x","")
EndFunc

;;; ############### FUNC :: msg_AddBytes ######## ;;;
;;; Function Name 	:	msg_AddBytes()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddBytes($Bytes="",$id=0)

	$Byte = StringSplit($Bytes,",")
	For $i = 1 to $Byte[0]
		msg_AddByte($Byte[$i],$id)
	Next

EndFunc

;;; ############### FUNC :: msg_AddSize ######## ;;;
;;; Function Name 	:	msg_AddSize()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_AddSize($id=0)

		$PACKET[$ID][0] = $PACKET[$ID][0] + 1
		$i = $PACKET[$ID][0]
		$PACKET[$id][$i] = "XXXXXXXX"

EndFunc

;;; ############### FUNC :: msg_ToStr ######## ;;;
;;; Function Name 	:	msg_ToStr()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_ToStr($id=0)

	$str=""
	for $i = 1 to $PACKET[$id][0]
		$str &= $PACKET[$id][$i]
	Next
	$str = StringReplace($str,"XXXXXXXX",_RotateHex(Hex((StringLen($str)/2)-5)))
	Return "0x"&$str

EndFunc

;;; ############### FUNC :: msg_setPac ######## ;;;
;;; Function Name 	:	msg_setPac()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_setPac($Str,$id=0)
	$PACK[$id][0] = StringReplace($str,"0x","")
EndFunc

;;; ############### FUNC :: msg_getByte ######## ;;;
;;; Function Name 	:	msg_getByte()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_getByte($count=1,$id=0)
	$str = $PACK[$id][0]
	$PACK[$id][1] = $PACK[$id][1] + 1
	$i = $PACK[$id][1]
	$PACK[$id][$i] = "0x"&StringLeft($str,$count*2)
	$PACK[$id][0] = StringRight($PACK[$id][0],StringLen($PACK[$id][0])-$count*2)
	Return $PACK[$id][$i]
EndFunc

;;; ############### FUNC :: msg_getInt ######## ;;;
;;; Function Name 	:	msg_getInt()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_getInt($type=$SHORT,$id=0)
	$str = $PACK[$id][0]
	$PACK[$id][1] = $PACK[$id][1] + 1
	$i = $PACK[$id][1]
	$PACK[$id][$i] = Dec(_RotateHex(StringLeft($str,$type)))
	$PACK[$id][0] = StringRight($str,StringLen($str)-$type)
	Return $PACK[$id][$i]
EndFunc

;;; ############### FUNC :: msg_getString ######## ;;;
;;; Function Name 	:	msg_getStr()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_getString($id=0)
	$str_len = msg_getInt($SHORT,$id) * 2
	$str = $PACK[$id][0]
	$PACK[$id][1] = $PACK[$id][1] + 1
	$i = $PACK[$id][1]
	
	$PACK[$id][$i] = BinaryToString("0x"&StringLeft($str,$str_len))
	$PACK[$id][0] = StringRight($str,StringLen($str)-$str_len)
	Return $PACK[$id][$i]
EndFunc

;;; ############### FUNC :: msg_GetCommand ######## ;;;
;;; Function Name 	:	msg_GetCommand()
;;; Author 			:	Jiyan Akgül ( jiyan aka jiyan006 )
;;; '-> mail		:	jiyan006@live.de
;;; Description 	:	LOOK AT HELPFILE
;;; Parameters		:	LOOK AT HELPFILE
;;; Return			:	LOOK AT HELPFILE
;;; (c) 2009 Jiyan Akgül
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func msg_GetCommand($id=0)
	$command=0xFFFFFFFF
	$step = 0
	Do
		if $step = 100 Then ExitLoop
		$hex = msg_getByte(4,$id)
		$step = $step +1
	Until $hex = $command
	$str = $PACK[$id][0]
	$PACK[$id][1] = $PACK[$id][1] + 1
	$i = $PACK[$id][1]
	$PACK[$id][$i] = StringLeft($str,$SHORT)
	$PACK[$id][0] = StringRight($str,StringLen($str)-$SHORT)
	Return $PACK[$id][$i]
EndFunc


; ROTATE HEX 
; (c) 2009 BY RYNTI 
Func _RotateHex($hex)
	$hexlen = StringLen($hex)
	For $i = 0 To $hexlen*2 - 1
		$hex = StringMid($hex, 3, StringLen($hex) - $i * 2) & StringLeft($hex, 2) & StringRight($hex, $i * 2)
	Next
	Return StringRight($hex, $hexlen)
EndFunc   ;==>_RotateHex
