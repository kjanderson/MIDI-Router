'**********************************************************************
' tb.vbs
'
' Description
' This script simulates the top-level module.
'**********************************************************************
' state definition
Private Const ST_IDLE = 0
Private Const ST_LAT_CMD = 1
Private Const ST_CMD = 2
Private Const ST_WR_DATA = 3
Private Const ST_WR_PREP = 4
Private Const ST_WR_EXE = 5
Private Const ST_RD_PREP = 6
Private Const ST_RD_EXE = 7
Private Const ST_RD_LOAD = 8
Private Const ST_RD_DATA = 9
Private Const ST_CLR = 10

Class spislave
    Private int_ss
    Private int_sr
    Private int_sdo
    Private int_rdy

    Public Property Get SpiRdy()
        SpiRdy = int_rdy
    End Property

    Public Sub Tick()
        int_rdy = 0
    End Sub

    Public Sub DataXchg(dataIn, ByRef dataOut)
        dataOut = int_sr
        int_sr = dataIn
        int_rdy = 1
    End Sub
End Class

Class spi_ctrl
    'internal registers
    Private int_spi_curr_state
    Private int_cmd
    Private int_addr
    Private int_data
    Private int_spi_data_i
    Private int_spi_data_o
    Private spi_ld
    Private int_wb_stb_o
    Private int_wb_we_o
    Private wb_dat_i

    'internal signals
    Private int_spi_rdy
    Private int_timeout
    Private wb_ack_i

    Private s0

    Public Sub Class_Initialize()
        Set s0 = New spislave
    End Sub

    Public Property Get SpiCommand()
        SpiCommand = int_cmd
    End Property

    Public Property Let WishboneAck(ack)
        wb_ack_i = ack
    End Property

    Public Property Let SetWishboneData(data)
        wb_dat_i = data
    End Property

    Public Property Get GetWishboneAddress()
        SpiAddress = int_addr
    End Property

    Public Property Get GetWishboneData()
        GetWishboneData = int_data
    End Property

    Public Property Get GetWishboneStrobe()
        GetWishboneStrobe = int_wb_stb_o
    End Property

    Public Property Get GetWishboneWriteEnable()
        GetWishboneWriteEnable = int_wb_we_o
    End Property

    Public Sub DataXchg(dataIn, ByRef dataOut)
        s0.DataXchg dataIn, dataOut
        int_spi_rdy = s0.SpiRdy
    End Sub

    Public Sub ShowLabels()
        WScript.Echo("Command, Address, Load, wb_we, Curr State")
    End Sub

    Public Sub Show()
        WScript.Echo(CStr(int_cmd) + ", " + CStr(int_addr) + ", " + CStr(spi_ld) + ", " + CStr(int_wb_we_o) + ", " + CStr(int_spi_curr_state))
    End Sub

    Public Sub Tick()
        int_spi_rdy = s0.SpiRdy

        Select Case int_spi_curr_state
        Case ST_IDLE
            spi_ld = 0
            int_addr = 0
            int_wb_we_o = 0
            int_cmd = 0
            If (int_spi_rdy = 1) Then
                int_spi_curr_state = ST_LAT_CMD
            Else
                int_spi_curr_state = ST_IDLE
            End If
        Case ST_LAT_CMD
            int_cmd = int_spi_data_o / 128
            int_addr = int_spi_data_o And 127
            int_spi_curr_state = ST_CMD
        Case ST_CMD
            If (int_cmd = 1) Then
                int_spi_curr_state = ST_WR_DATA
            Else
                int_spi_curr_state = ST_RD_PREP
            End If
        Case ST_WR_DATA
            If (int_spi_rdy = 1) Then
                int_spi_curr_state = ST_WR_PREP
            Else
                int_spi_curr_state = ST_WR_DATA
            End If
        Case ST_WR_PREP
            int_wb_stb_o = 1
            int_wb_we_o = 1
            int_data = int_spi_data_o
            int_spi_curr_state = ST_WR_EXE
        Case ST_WR_EXE
            If (wb_ack_i = 1) Then
                int_spi_curr_state = ST_CLR
            Else
                int_spi_curr_state = ST_WR_EXE
            End If
        Case ST_RD_PREP
            int_wb_stb_o = 1
            int_wb_we_o = 0
            int_spi_curr_state = ST_RD_EXE
        Case ST_RD_EXE
            If (wb_ack_i = 1) Then
                int_spi_curr_state = ST_RD_LOAD
            Else
                int_spi_curr_state = ST_RD_EXE
            End If
        Case ST_RD_LOAD
            int_wb_stb_o = 0
            int_wb_we_o = 0
            spi_ld = 1
            int_spi_data_i = wb_dat_i
            int_spi_curr_state = ST_RD_DATA
        Case ST_RD_DATA
            spi_ld = 0
            If (int_spi_rdy = 1) Then
                int_spi_curr_state = ST_CLR
            Else
                int_spi_curr_state = ST_RD_DATA
            End If
        Case ST_CLR
            int_wb_stb_o = 0
            int_wb_we_o = 0
            int_spi_curr_state = ST_IDLE
        Case Else
            int_spi_curr_state = ST_IDLE
        End Select

        s0.Tick()
    End Sub
End Class

Class up_counter
    Private int_cnt

    Public Sub Tick(clr)
        If (clr = 1) Then
            int_cnt = 0
        Else
            int_cnt = int_cnt + 1
        End If
    End Sub
End Class

Class ram
    Private mem_buf

    Private wb_ack
    Private wb_addr_i
    Private wb_dat_o
    Private wb_stb_i
    Private wb_we_i
    Private ram_buffer(256)

    Public Sub Class_Initialize()
        wb_ack = 1
    End Sub

    Public Property Let SetWishboneAddress(addr)
        wb_addr_i = addr
    End Property

    Public Property Let SetWishboneData(data)
        wb_dat_i = data
    End Property

    Public Property Let SetWishboneStrobe(stb)
        wb_stb_i = stb
    End Property

    Public Property Let SetWishboneWriteEnable(we)
        wb_we_i = we
    End Property

    Public Property Get WishboneAck()
        WishboneAck = wb_ack
    End Property

    Public Property Get GetWishboneData()
        GetWishboneData = wb_dat_o
    End Property

    Public Sub Tick()
        If ((wb_we_i = 1) And (wb_stb_i = 1)) Then
            ram_buffer(wb_addr_i) = wb_data_i
        End If
        If ((wb_we_i = 0) And (wb_stb_i = 1)) Then
            wb_data_o = ram_buffer(wb_addr_i)
        End If
    End Sub
End Class

WScript.Echo("tb.vbs")
Dim s0
Dim r0
Dim wb_ack
Dim wb_mst_data_i
Dim wb_mst_data_o
Dim wb_addr
Dim wb_stb
Dim wb_we
Set s0 = New spi_ctrl
Set r0 = New ram
s0.Tick()

Dim loopDone
Dim cnt
Dim spi_data_o

loopDone = False
s0.ShowLabels
cnt = 0
s0.Show()
    ' issue a read command from address 0
s0.DataXchg 0, spi_data_o
while (loopDone = False)
    cnt = cnt + 1
    if (cnt > 10) Then
        loopDone = True
    End If

    ' setup RTL signals
    wb_ack = r0.WishboneAck
    s0.WishboneAck = wb_ack
    wb_mst_data_i = r0.GetWishboneData
    s0.SetWishboneData = wb_mst_data_i
    wb_mst_data_o = s0.GetWishboneData
    r0.SetWishboneData = wb_mst_data_o
    wb_addr = s0.GetWishboneAddress
    r0.SetWishboneAddress = wb_addr
    wb_stb = s0.GetWishboneStrobe
    r0.SetWishboneStrobe = wb_stb
    wb_we = s0.GetWishboneWriteEnable
    r0.SetWishboneWriteEnable = wb_we

    ' trigger clock to all modules
    s0.Tick()
    r0.Tick()

    ' update printed table
    s0.Show()
Wend
