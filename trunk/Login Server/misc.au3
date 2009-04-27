#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Jiyan Akgül
 APSP Revision:  1.0
 Misc Version : 1.0

		::FUNCS::
	cout( $Text ) ; Writes $Text into the Console and into the LogFile
#ce ----------------------------------------------------------------------------
$Time = 0

$MysqL_Config = "mysql.config"

Func cout( $Text )
	ConsoleWrite( $Text & @CRLF )
EndFunc

Func _ConfGetMySQL()
	Local $MyDATA[3][5]
	
	;;; APSP_SERVER ;;;;
	_XML_Open($MysqL_Config,1)
	_XML_Set_Base("Server")
	
	$MyDATA[0][0] = _XML_Get_Value("host")
	$MyDATA[0][1] = _XML_Get_Value("username")
	$MyDATA[0][2] = _XML_Get_Value("password")
	$MyDATA[0][3] = _XML_Get_Value("DataBase")
	$MyDATA[0][4] = _XML_Get_Value("port")
	
	;;; APSP_CHARACTERS ;;;;
	_XML_Open($MysqL_Config,1)
	_XML_Set_Base("Character",2)
	
	$MyDATA[1][0] = _XML_Get_Value("host")
	$MyDATA[1][1] = _XML_Get_Value("username")
	$MyDATA[1][2] = _XML_Get_Value("password")
	$MyDATA[1][3] = _XML_Get_Value("DataBase")
	$MyDATA[1][4] = _XML_Get_Value("port")
	
	;;; APSP_WORLD ;;;;
	_XML_Open($MysqL_Config,1)
	_XML_Set_Base("World",3)
	
	$MyDATA[2][0] = _XML_Get_Value("host")
	$MyDATA[2][1] = _XML_Get_Value("username")
	$MyDATA[2][2] = _XML_Get_Value("password")
	$MyDATA[2][3] = _XML_Get_Value("DataBase")
	$MyDATA[2][4] = _XML_Get_Value("port")
	
	Return $MyDATA
	
EndFunc


Func __stoptime()
	$Time = $Time + 1
EndFunc   ;==>__stoptime