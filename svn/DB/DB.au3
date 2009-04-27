#include "mysql.au3"




_MySQL_InitLibrary()

$MyDATA = _ConfGetMySQL()


Func _ConnToChar()

	$MysqlChar = _MySQL_Init()

	$HOST = $MyDATA[1][0]
	$USER = $MyDATA[1][1]
	$PASS = $MyDATA[1][2]
	$BASE = $MyDATA[1][3]
	$PORT = $MyDATA[1][4]

	$apsp_chara = _MySQL_Real_Connect($MysqlChar, $HOST, $USER, $PASS, $BASE, $PORT)

	If $apsp_chara = 0 Then
		cout('[DB] MySQL Connection Error (apsp_characters) :: ' & _MySQL_Error($MysqlChar) & "Exit Now")
		Sleep(1000)
		Exit
	EndIf

	Return $MysqlChar
EndFunc   ;==>_ConnToChar

Func _ConnToServ()

	$MysqlConn = _MySQL_Init()

	$HOST = $MyDATA[0][0]
	$USER = $MyDATA[0][1]
	$PASS = $MyDATA[0][2]
	$BASE = $MyDATA[0][3]
	$PORT = $MyDATA[0][4]

	$apsp_server = _MySQL_Real_Connect($MysqlConn, $HOST, $USER, $PASS, $BASE, $PORT)

	If $apsp_server = 0 Then
		cout('[DB] MySQL Connection Error (apsp_server) :: ' & _MySQL_Error($MysqlConn) & "Exit Now")
		Sleep(1000)
		Exit
	EndIf
	Return $MysqlConn
EndFunc   ;==>_ConnToServ


Func _DB_read($string, $conn, $row, $table = "accounts")
	$query = "SELECT " & $row & " FROM " & $table & " WHERE " & $row & " = '" & $string & "'"
	_MySQL_Real_Query($conn, $query)

	$res = _MySQL_Store_Result($conn)

	$field = _MySQL_Num_Fields($res)

	$mysqlrow = _MySQL_Fetch_Row($res, $field)

	$lenthsStruct = _MySQL_Fetch_Lengths($res)

	$length = DllStructGetData($lenthsStruct, 1, 1)
	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
	$data = DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)

	Return $data
EndFunc   ;==>_DB_read

Func _DB_write($string, $row, $row2, $string2, $conn, $table = "accounts")
	$query = "UPDATE " & $table & " SET " & $row & "='" & $string & "' WHERE " & $row2 & "='" & $string2 & "'"
	_MySQL_Real_Query($conn, $query)

EndFunc   ;==>_DB_write


Func _DB_get_Servers($MysqlConn)
	$AllServer = _CountFields("server", $MysqlConn,"Server_ID")
	Return $AllServer
EndFunc   ;==>_DB_get_Servers

Func _DB_get_Channels($MysqlConn, $serv = 0)
	If $serv <> 0 Then
		$query = "SELECT Channel_ID FROM channel WHERE Server_ID = '"&$serv&"'"
		_MySQL_Real_Query($MysqlConn, $query)
		$res = _MySQL_Store_Result($MysqlConn)
		$field = _MySQL_Num_Fields($res)
		$rows = _MySQL_Num_Rows($res)
		Return $rows
	Else
		$allChannel = _CountFields("channel", $MysqlConn, "Channel_ID")
		Return $allChannel
	EndIf
EndFunc   ;==>_DB_get_Channels

Func _DB_get_Server_info($id, $conn)
	Local $return[2]
	$query = "SELECT Server_Name FROM Server WHERE Server_ID = '" & $id & "'"
	_MySQL_Real_Query($conn, $query)
	$res = _MySQL_Store_Result($conn)
	$field = _MySQL_Num_Fields($res)
	$mysqlrow = _MySQL_Fetch_Row($res, $field)
	$lenthsStruct = _MySQL_Fetch_Lengths($res)
	$length = DllStructGetData($lenthsStruct, 1, 1)
	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
	$return[0] =  DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)
	;; FOLGENDES WIRD GERADE NET BENUTZT DA ES NOCH KEINEN CHAR SERVER GIBT ;)
;~ 	$query = "SELECT Server_IP FROM Server WHERE Server_ID = '" & $id & "'"
;~ 	_MySQL_Real_Query($conn, $query)
;~ 	$res = _MySQL_Store_Result($conn)
;~ 	$field = _MySQL_Num_Fields($res)
;~ 	$mysqlrow = _MySQL_Fetch_Row($res, $field)
;~ 	$lenthsStruct = _MySQL_Fetch_Lengths($res)
;~ 	$length = DllStructGetData($lenthsStruct, 1, 1)
;~ 	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
;~ 	$return[1] =  DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)
	Return $return
EndFunc


Func _DB_get_Channel_info($id, $conn)
	Local $return[3]
	$query = "SELECT Max_Users FROM channel_users WHERE Channel_ID = '" & $id & "'"
	_MySQL_Real_Query($conn, $query)
	$res = _MySQL_Store_Result($conn)
	$field = _MySQL_Num_Fields($res)
	$mysqlrow = _MySQL_Fetch_Row($res, $field)
	$lenthsStruct = _MySQL_Fetch_Lengths($res)
	$length = DllStructGetData($lenthsStruct, 1, 1)
	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
	$return[2] = DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)
	;;
	$query = "SELECT Current_Users FROM channel_users WHERE Channel_ID = '" & $id & "'"
	_MySQL_Real_Query($conn, $query)
	$res = _MySQL_Store_Result($conn)
	$field = _MySQL_Num_Fields($res)
	$mysqlrow = _MySQL_Fetch_Row($res, $field)
	$lenthsStruct = _MySQL_Fetch_Lengths($res)
	$length = DllStructGetData($lenthsStruct, 1, 1)
	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
	$return[1] = DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)
	;;
	$query = "SELECT Channel_Name FROM channel WHERE Channel_ID = '" & $id & "'"
	_MySQL_Real_Query($conn, $query)
	$res = _MySQL_Store_Result($conn)
	$field = _MySQL_Num_Fields($res)
	$mysqlrow = _MySQL_Fetch_Row($res, $field)
	$lenthsStruct = _MySQL_Fetch_Lengths($res)
	$length = DllStructGetData($lenthsStruct, 1, 1)
	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
	$return[0] = DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)
	Return $return
EndFunc   ;==>_DB_get_Channel_info


Func _DB_get_Channels_byid($ServerID, $MysqlConn)

	Local $CHANNEL[13]
	$CHANNEL[0] = 0
	$allChannel = _CountFields("channel", $MysqlConn, "Channel_ID")

	For $i = 1 To $allChannel
		$chann = _GetServerByID($i, $MysqlConn, "Channel_ID")
		If $chann = $ServerID Then
			$CHANNEL[0] = $CHANNEL[0] + 1

			$CHANNEL[$i] = _GetServerByID($i, $MysqlConn, "Channel_Name")
		EndIf
	Next
	Return $CHANNEL

EndFunc   ;==>_DB_get_Channels_byid


Func _CountFields($table, $PTR, $row)
	$query = "SELECT " & $row & " FROM " & $table
	_MySQL_Real_Query($PTR, $query)

	$res = _MySQL_Store_Result($PTR)

	$field = _MySQL_Num_Fields($res)
	$rows = _MySQL_Num_Rows($res)

	Return $rows

EndFunc   ;==>_CountFields


Func _GetServerByID($id, $conn, $row = "Server_Name", $row_id = "Server_ID", $table = "channel")

	$query = "SELECT " & $row & " FROM " & $table & " WHERE " & $row_id & " = '" & $id & "'"
	_MySQL_Real_Query($conn, $query)

	$res = _MySQL_Store_Result($conn)

	$field = _MySQL_Num_Fields($res)

	$mysqlrow = _MySQL_Fetch_Row($res, $field)

	$lenthsStruct = _MySQL_Fetch_Lengths($res)

	$length = DllStructGetData($lenthsStruct, 1, 1)
	$fieldPtr = DllStructGetData($mysqlrow, 1, 1)
	$data = DllStructGetData(DllStructCreate("char[" & $length & "]", $fieldPtr), 1)

	Return $data

EndFunc   ;==>_GetServerByID

