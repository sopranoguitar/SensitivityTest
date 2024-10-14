#include TextRender.ahk

iMode := 1
tMode := TextRender()
iPixels := 0
tPixels := TextRender()
iIncrement := 1
tIncrement := TextRender()
tLabel1 := TextRender()
tLabel2 := TextRender()
tLabel3 := TextRender()
tLabel4 := TextRender()
tLabel5 := TextRender()
tLabel6 := TextRender()
tLabel7 := TextRender()
tLabel8 := TextRender()
tLabel9 := TextRender()

MoveMouse(x, y)
{
	DllCall("mouse_event", "UInt", 0x01, "UInt", x, "UInt", y)
}
*~$1::
{
	global iPixels
	if (iMode == 1)
		MoveMouse(iPixels, 0)
	else
		MoveMouse(0, iPixels)
}
*~$2::
{
	global iPixels
	While (GetKeyState("2", "P"))
	{
		iPixels++
		if (iMode == 1)
			MoveMouse(1, 0)
		else
			MoveMouse(0, 1)
	}
}
*~$3::
{
	global iPixels
	iPixels -= iIncrement
}
*~$4::
{
	global iPixels
	iPixels += iIncrement
}
*~$5::
{
	global iIncrement
	iIncrement := max(iIncrement - 1, 1)
}
*~$6::
{
	global iIncrement
	iIncrement++
}
*~$7::
{
	global iMode
	iMode := iMode == 1 ? 2 : 1
}
*~$0::
{
	global iPixels, iIncrement
	iPixels := 0
	iIncrement := 1
}

SetTimer coroutine, 10
coroutine()
{
    tPixels.Render(Format("Pixels: {}", iPixels),
        { x: "right", y: "top - 4", c: 0x50000000, m: 0 },
        "s:5vmin")
	
    if (tMode.w == "")
		tMode.w := 0 ; make sure this isn't a string
    tMode.Render(Format("Mode: {}", iMode == 1 ? "horizontal" : "vertical"),
        { x: tPixels.x - tMode.w - 10, y: "top", c: 0x50000000, m: 0 },
        "s:3vmin")
	
    if (tIncrement.w == "")
		tIncrement.w := 0 ; make sure this isn't a string
    tIncrement.Render(Format("Increment: {}", iIncrement),
        { x: tPixels.x - tIncrement.w - 10, y: tMode.y + tMode.h, c: 0x50000000, m: 0 },
        "s:3vmin")
	
	tLabel1.Render("1: Test",
        { x: "right", y: tPixels.y + tPixels.h + 10, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("1", "P") ? 1 : 0))
	tLabel2.Render("2: Turn + increment",
        { x: "right", y: tLabel1.y + tLabel1.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("2", "P") ? 1 : 0))
	tLabel3.Render("3: Decrease pixels",
        { x: "right", y: tLabel2.y + tLabel2.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("3", "P") ? 1 : 0))
	tLabel4.Render("4: Increase pixels",
        { x: "right", y: tLabel3.y + tLabel3.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("4", "P") ? 1 : 0))
	tLabel5.Render("5: Decrease increment",
        { x: "right", y: tLabel4.y + tLabel4.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("5", "P") ? 1 : 0))
	tLabel6.Render("6: Increase increment",
        { x: "right", y: tLabel5.y + tLabel5.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("6", "P") ? 1 : 0))
	tLabel7.Render("7: Change mode",
        { x: "right", y: tLabel6.y + tLabel6.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("7", "P") ? 1 : 0))
	tLabel8.Render("0: Reset",
        { x: "right", y: tLabel7.y + tLabel7.h, c: 0x50000000, m: 0 },
        Format("s:2vmin, b:{}", GetKeyState("0", "P") ? 1 : 0))
	tLabel9.Render("Delete: Exit",
        { x: "right", y: tLabel8.y + tLabel8.h, c: 0x50000000, m: 0 },
        "s:2vmin")
}

Delete:: ExitApp