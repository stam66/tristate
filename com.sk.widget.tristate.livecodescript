script "com.sk.tristate.livecodescript"
/**
Title: Tri-state switch 1.0.4

Author: Stam Kapetanakis

Version: 1.0.4

Type: Widget

SVGIcon: M75.1875 98.9688C60.0318 98.9687 47.7188 111.251 47.7188 126.406L47.7188 128.688C47.7187 143.843 60.0318 156.125 75.1875 156.125L152.406 156.125C167.562 156.125 179.844 143.843 179.844 128.688L179.844 126.406C179.844 111.251 167.562 98.9688 152.406 98.9688L75.1875 98.9688ZM113.781 101.062C128.417 101.062 140.281 112.927 140.281 127.562C140.281 142.198 128.417 154.063 113.781 154.062C99.1457 154.062 87.2813 142.198 87.2812 127.562C87.2812 112.927 99.1457 101.062 113.781 101.062Z

Summary: Switch control with 3 states

Description:
A switch control with 3 states (left/center/right)

In edit mode, resize in IDE to set size and aspect ratio. 
Assign a value (left, center or right) setting the switchValue either by code or in property panel.
Click on each 3rd of the widget to set switch in browse mode. Drag indicator to move 1 step in drag direction.
Each switchValue can set a different color to the widget.
Colours are set in the property panel or by code (set the leftColor, centerColor, rightColor and indicatorColor respectively).

New in 1.0.3: Optionally assign labels. In the middle/neutral state, there are 1 labels (ideally 1 char only) either side of the indicator.
In left or right postions a full label is displayed - however bounts are not checked so resize as needed.
The text is dynamically resized by height of widget, constrained by a min and max set in preferences.
textColor is dynamically changed to light or dark depending on if background is dark or light respectively
*/

getProp propertyMetadata[pProperty]
    switch pProperty
        case "rightColor"
            return { \
                  "default": "201,0,118", \
                  "label": "Color when switch in right position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "leftColor"
            return { \
                  "default": "41,134,204", \
                  "label": "Color when switch in left position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "centerColor"
            return { \
                  "default": "244,246,247", \
                  "label": "Color when switch in centre position", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "indicatorColor"
            return { \
                  "default": "230,232,232", \
                  "label": "Color of indicator switch", \
                  "editor": "com.livecode.pi.color", \
                  "section": "Colors" }
            break
            
        case "switchValue"
            return { \
                  "default": "Center", \
                  "label": "Switch position", \
                  "editor": "com.livecode.pi.enum", \
                  "options": "Left,Center,Right", \
                  "section": "Basic" }
            break
            
        case "hasLabels"
            return { \
                  "default": "True", \
                  "label": "Show/Hide labels", \
                  "editor": "com.livecode.pi.boolean", \
                  "section": "basic"}
            break
            
        case "leftText"
            return { \
                  "default" : "Left", \
                  "label": "Label when indicator is left", \
                  "editor": "com.livecode.pi.text", \
                  "section": "contents"}
            break
            		
        case "leftTextSmall"
            return { \
                  "default": "L", \
                  "label": "Short left label when center postioned", \
                  "editor": "com.livecode.pi.text", \
                  "section": "contents"}
            break
            		
        case "rightText"
            return { \
                  "default" : "Right", \
                  "label": "Label when indicator is right", \
                  "editor": "com.livecode.pi.text", \
                  "section": "contents"}
            break
            		
        case "rightTextSmall"
            return { \
                  "default": "R", \
                  "label": "Short right label when center postioned", \
                  "editor": "com.livecode.pi.text", \
                  "section": "contents"}
            break
            			
        case "maxTextSize"
            return { \
                  "default": "30", \
                  "label": "Max label textSize", \
                  "editor": "com.livecode.pi.number", \
                  "section": "text"}
            break
            
        case "minTextSize"
            return { \
                  "default": "10", \
                  "label": "Min label textSize", \
                  "editor": "com.livecode.pi.number", \
                  "section": "text"}
            break
            
    end switch
end propertyMetadata


local sHasCreatedVisuals, sMouseX, sClickedIndicator
local sBackroundID, sIndicatorID, sTextLeftID, sTextRightID, sTextLongID

########################### PROPERTIES ###########################
// rightColor
getProp rightColor
	local tColor
	put the rightColor of me into tColor
	if tColor is empty then put "#C90076" into tColor
	return tColor
end rightColor

setProp rightColor pColor
	set the rightColor of me to pColor
	updateVisualControls
end rightColor

// leftColor
getProp leftColor
	local tColor
	put the leftColor of me into tColor
	if tColor is empty then put "#2986CC" into tColor
	return tColor
end leftColor

setProp leftColor pColor
	set the leftColor of me to pColor
	updateVisualControls
end leftColor

// centerColor
getProp centerColor
	local tColor
	put the centerColor of me into tColor
	if tColor is empty then put "#F4F6F7" into tColor
	return tColor
end centerColor

setProp centerColor pColor
	set the centerColor of me to pColor
	updateVisualControls
end centerColor

// indicatorColor
getProp indicatorColor
	local tColor
	put the indicatorColor of me into tColor
	if tColor is empty then put "#E6E8E8" into tColor
	return tColor
end indicatorColor

setProp indicatorColor pColor
	set the indicatorColor of me to pColor
	updateVisualControls
end indicatorColor

// switchValue
getProp switchValue
	local tValue
	put the switchValue of me into tValue
	if tValue is empty then put "Center" into tValue
	return tValue
end switchValue

setProp switchValue pValue
	set the switchValue of me to pValue
	updateIndicatorForValue
end switchValue

// left text
getProp leftText
	local tText
	put the leftText of me into tText
	if tText is empty then put "Left" into tText
	return tText
end leftText

setProp leftText pText
	set the leftText of me to pText
	updateVisualControls
end leftText

// Left text small
getProp leftTextSmall
	local tText
	put the leftTextSmall of me into tText
	if tText is empty then put "L" into tText
	return tText
end leftTextSmall

setProp leftTextSmall pText
	set the leftTextSmall of me to pText
	updateVisualControls
end leftTextSmall

// right text
getProp rightText
	local tText
	put the rightText of me into tText
	if tText is empty then put "Right" into tText
	return tText
end rightText

setProp rightText pText
	set the rightText of me to pText
	updateVisualControls
end rightText

// Right text small
getProp rightTextSmall
	local tText
	put the rightTextSmall of me into tText
	if tText is empty then put "R" into tText
	return tText
end rightTextSmall

setProp rightTextSmall pText
	set the rightTextSmall of me to pText
	updateVisualControls
end rightTextSmall

// max label textSize
getProp maxTextSize
	local tSize
	put the maxTextSize of me into tSize
	if tSize is empty then put 30 into tSize
	return tSize
end maxTextSize

setProp maxTextSize pSize
	set the maxTextSize of me to pSize
	updateVisualControls
end maxTextSize

// min labeL textSize
getProp minTextSize
	local tSize
	put the minTextSize of me into tSize
	if tSize is empty then put 9 into tSize
	return tSize
end minTextSize

setProp minTextSize pSize
	set the minTextSize of me to pSize
	updateVisualControls
end minTextSize

// hasLabels
getProp hasLabels
    local tBool
    put the hasLabels of me into tBool
    if tBool is empty then put true into tBool
    return tBool
end hasLabels

setProp hasLabels pHasLabels
    if pHasLabels is not a boolean then
        return "Invalid parameter: not a boolean"
        exit hasLabels
    end if
    set the hasLabels of me to pHasLabels
    updateVisualControls
end hasLabels

########################### /PROPERTIES ##########################

on openControl
	createVisualControls
	layoutVisualControls
	updateVisualControls
end openControl

on resizeControl
    if not sHasCreatedVisuals then exit resizeControl
    layoutVisualControls
    formatTextFields
end resizeControl

private command createVisualControls
    if sHasCreatedVisuals then exit createVisualControls
    set the clipsToRect of me to true
    lock screen
    // background
    create graphic "background" in me
    put the id of graphic "background" of me into sBackroundID
    set the style of control id sBackroundID to "roundRect"
    set the opaque of control id sBackroundID to true
    set the linesize of control id sBackroundID to 1
    	
    // labels
    set the margins of the templateField to "0,8,0,8"
    set the opaque of the templateField to false
    set the showBorder of the templateField to false
    set the threeD of the templateField to false
    set the locktext of the templateField to true
    set the dontWrap of the templateField to true
    set the traversalOn of the templateField to false
    set the showFocusBorder of the templateField to false
    set the textAlign of the templateField to "center"
    create field "textLong" in me
    put the id of field "textLong" of me into sTextLongID
    create field "textLeft" in me
    put the id of field "textLeft" of me into sTextLeftID
    create field "textRight" in me
    put the id of field "textRight" of me into sTextRightID
    
    // indicator
    create graphic "indicator" in me
    put the id of graphic "indicator" of me into sIndicatorID
    set the style of control id sIndicatorID to "oval"
    set the opaque of control id sIndicatorID to true
    set the linesize of control id sIndicatorID to 1
    set the backgroundColor of control id sIndicatorID to "#E6E8E8"
    local tInnerGlow
    put "normal" into tInnerGlow["blendMode"]
    put 255, 255, 255 into tInnerGlow["color"]
    put "gaussian" into tInnerGlow["filter"]
    put 255 into tInnerGlow["opacity"]
    put 255 into tInnerGlow["range"]
    put 20 into tInnerGlow["size"]
    put "edge" into tInnerGlow["source"]
    put 0 into tInnerGlow["spread"]
    set the innerGlow of control id sIndicatorID to tInnerGlow
    
    set the switchValue of me to "center"
    
    if the width of me is empty or the width of me is 0 then
        set the width of me to 120
        set the height of me to 70
    end if
    
    put true into sHasCreatedVisuals
    reset the templateGraphic
    reset the templateField
    layoutVisualControls
end createVisualControls

private command layoutVisualControls ## fix by Bernd to stop the mesmerising wandering of the indicator...
	if not sHasCreatedVisuals then exit layoutVisualControls

	local tRect, tDiameter
	lock screen
	// background rect
	put the rect of me into tRect
	add 2 to item 1 of tRect
	add 2 to item 2 of tRect
	subtract 2 from item 3 of tRect
	subtract 2 from item 4 of tRect
	set the rect of control id sBackroundID to tRect
	// indicator rect
	put the height of control id sBackroundID - 4 into tDiameter
	set the width of control id sIndicatorID to tDiameter
	set the height of control id sIndicatorID to tDiameter

	## resize the indicator in current location
	switch the switchValue of me
		case "Left"
			set the left of control id sIndicatorID to the left of control id sBackroundID + 2
			set the top of control id sIndicatorID to the top of control id sBackroundID + 2
			break
		case "Center"
			set the loc of control id sIndicatorID to the loc of control id sBackroundID
			break
		case "Right"
			set the right of control id sIndicatorID to the right of control id sBackroundID - 2
			set the top of control id sIndicatorID to the top of control id sBackroundID + 2
			break
	end switch
	set the roundRadius of control id sBackroundID to tDiameter

	if the mouse is up then updateIndicatorForValue
end layoutVisualControls

private command updateVisualControls
	if not sHasCreatedVisuals then exit updateVisualControls
	switch the switchValue of me
		case "Left"
			set the backgroundColor of control id sBackroundID to the leftColor of me
			break
		case "Center"
			set the backgroundColor of control id sBackroundID to the centerColor of me
			break
		case "Right"
			set the backgroundColor of control id sBackroundID to the rightColor of me
			break
	end switch
	set the backgroundColor of control id sIndicatorID to the indicatorColor of me
    // display and set text labels
	formatTextFields
end updateVisualControls


private command formatTextFields
    if not sHasCreatedVisuals then exit formatTextFields
    if the hasLabels of me is false then
        hide control id sTextLongID
        hide control id sTextLeftID
        hide control id sTextRightID
        exit formatTextFields
    else
        local tOffset, tSize
        put (the width of control id sBackroundID - the width of control id sIndicatorID) / 4 into tOffset
        ------- text field rects ------
        // resize/reposition long label
        set the width of control id sTextLongID to the width of control id sBackroundID - the width of control id sIndicatorID - 20
        set the height of control id sTextLongID to the height of control id sBackroundID
        set the loc of control id sTextLongID to the loc of control id sBackroundID
        // resize/reposition left text label
        set the width of control id sTextLeftID to the width of control id sIndicatorID / 2
        set the height of control id sTextLeftID to the height of control id sBackroundID
        set the loc of control id sTextLeftID to the the left of control id sBackroundID + tOffset, item 2 of the loc of control id sBackroundID
        // resize/reposition right text label
        set the width of control id sTextRightID to the width of control id sIndicatorID / 2
        set the height of control id sTextRightID to the height of control id sBackroundID
        set the loc of control id sTextRightID to the right of control id sBackroundID - tOffset, item 2 of the loc of control id sBackroundID
        
        ------- format field text ------
        # get text size
        if length(the leftText of me) > length(the rightText of me) then
            set the text of control id sTextLongID to the leftText of me
        else
            set the text of control id sTextLongID to the rightText of me
        end if
        put the maxTextSize of me into tSize
        repeat
            set the textSize of control id sTextLongID to tSize
            if the formattedHeight of control id sTextLongID > the height of control id sTextLongID then
                subtract 1 from tSize
            else
                exit repeat
            end if
            if tSize <= the minTextSize of me then exit repeat
        end repeat
        # apply textSize, topMargin, appropriate textColor for background
        lock screen
        formatFieldText tSize, sTextLeftID
        formatFieldText tSize, sTextRightID
        formatFieldText tSize, sTextLongID
        
        ------- field text ------
        // show/hide fields and set text values
        switch the switchValue of me
            case "left"
                hide control id sTextLeftID
                hide control id sTextRightID
                set the left of control id sTextLongID to the right of control id sIndicatorID + 5
                set the text of control id sTextLongID to the leftText of me
                show control id sTextLongID
                break
            case "center"
                hide control id sTextLongID
                set the text of control id sTextLeftID to the leftTextSmall of me
                set the text of control id sTextRightID to the rightTextSmall of me
                show control id sTextLeftID
                show control id sTextRightID
                break
            case "right"
                hide control id sTextLeftID
                hide control id sTextRightID
                set the right of control id sTextLongID to the left of control id sIndicatorID - 5
                set the text of control id sTextLongID to the rightText of me
                show control id sTextLongID
        end switch
    end if
end formatTextFields

private command formatFieldText pSize, pControlID
    local tTextHeight, tFieldY, tFormatRect, tFormatheight, tFormatHalfHeight, tCurrFormatTop, tCenterField_To_TopTextDiff
   set the textColor of control id pControlID to textColorForBackground(the backgroundColor of control id sBackroundID)
   set the textSize of control id pControlID to pSize
 
   ## trying to keep text vertially centered
   put the effective textHeight of control id pControlID into tTextHeight
   put item 2 of the loc of control id pControlID into tfieldY
   
   put the formattedRect of line 1 to - 1 of control id pControlID into tFormatRect
   put item 4 of tFormatRect - item 2 of tFormatRect into tFormatHeight
   put tFormatHeight div 2 into tFormatHalfHeight
   
   put item 2 of tFormatRect into tCurrFormatTop
   put tfieldY - tCurrFormatTop into tCenterField_To_TopTextDiff
   
   set the topMargin of control id pControlID to the topMargin of control id pControlID \
         + tCenterField_To_TopTextDiff - tFormatHalfHeight
   ## end trying to keep text vertically centered
end formatFieldText


private command updateIndicatorForValue
    local tX
    if not sHasCreatedVisuals then exit updateIndicatorForValue
    	
    switch the switchValue of me
        case "Left"
            set the backgroundColor of control id sBackroundID to the leftColor of me
            put the left of control id sBackroundID + 3 + the width of control id sIndicatorID / 2 into tX
            move control id sIndicatorID to tX, item 2 of the loc of control id sBackroundID in 200 milliseconds
            set the left of control id sIndicatorID to the left of control id sBackroundID + 2
            break
        case "Center"
            set the backgroundColor of control id sBackroundID to the centerColor of me
            move control id sIndicatorID to the loc of control id sBackroundID in 200 milliseconds
            break
        case "Right"
            set the backgroundColor of control id sBackroundID to the rightColor of me
            put the right of control id sBackroundID - 3 - the width of control id sIndicatorID / 2 into tX
            move control id sIndicatorID to tX, item 2 of the loc of control id sBackroundID in 200 milliseconds
            set the right of control id sIndicatorID to the right of control id sBackroundID - 2
            break
    end switch
    formatTextFields
end updateIndicatorForValue

on mouseDown
	if the mouseLoc is within the rect of control id sIndicatorID then
		put true into sClickedIndicator
		put the mouseH into sMouseX
	end if
	pass mouseDown
end mouseDown

on mouseUp pKey
	local tSegmentClicked, tRect, tR1, tR2, tR3, t3
	if sClickedIndicator then   // drag indicator 1 step in drag direction
		local tValue
		put the switchValue of me into tValue
		if the mouseH - sMouseX > 0 and tValue is "Left" then // go right
			put "Center" into tValue
		else if the mouseH - sMouseX > 0 and tValue is "Center" then // go right
			put "Right" into tValue
		else if the mouseH - sMouseX < 0 and tValue is "Right" then //go left
			put "Center" into tValue
		else if the mouseH - sMouseX < 0 and tValue is "Center" then //go left
			put "Left" into tValue
		end if
		set the switchValue of me to tValue
	else                        // establish 3 click zones to see if left, centre or right
		put the width of control id sBackroundID / 3 into t3
		put the rect of control id sBackroundID into tR1
		put item 1 of tR1 + t3 into item 3 of tR1
		put tR1 into tR2
		add t3 to item 1 of tR2
		add t3 to item 3 of tR2
		put tR2 into tR3
		add t3 to item 1 of tR3
		add t3 to item 3 of tR3
		// apply value based on click zone
		if the mouseLoc is within tR1 then
			set the switchValue of me to "Left"
		else if the mouseLoc is within tR2 then
			set the switchValue of me to "Center"
		else if the mouseLoc is within tR3 then
			set the switchValue of me to "Right"
		end if
	end if
	put false into sClickedIndicator
	put empty into sMouseX
end mouseUp

on mouseRelease
    local tValue
    if not sClickedIndicator then exit to top // do not allow drag action if not initiated by clicking the indicator
    if "groupbehavior" is in the long name of the target then exit to top
    put the switchValue of me into tValue
    if the mouseH - sMouseX > 0 and tValue is "Left" then // go right
        put "Center" into tValue
    else if the mouseH - sMouseX > 0 and tValue is "Center" then // go right
        put "Right" into tValue
    else if the mouseH - sMouseX < 0 and tValue is "Right" then //go left
        put "Center" into tValue
    else if the mouseH - sMouseX < 0 and tValue is "Center" then //go left
        put "Left" into tValue
    end if
    set the switchValue of me to tValue
    put false into sClickedIndicator
    put empty into sMouseX
end mouseRelease

# return dark textColor for light backgrounds & vice versa
private function textColorForBackground pColor
    local hsp, r, g, b
    if char 1 of pColor is "#" and length(pColor) = 7 then // hex
        put baseConvert(char 2 to 3 of pColor, 16, 10) into r
        put baseConvert(char 4 to 5 of pColor, 16, 10) into g
        put baseConvert(char 6 to 7 of pColor, 16, 10) into b
    else if length(pColor) = 6 then
        put baseConvert(char 1 to 2 of pColor, 16, 10) into r
        put baseConvert(char 3 to 4 of pColor, 16, 10) into g
        put baseConvert(char 5 to 5 of pColor, 16, 10) into b
    else if pColor contains ","  then// rbg
        put item 1 of pColor into r
        put item 2 of pColor into g
        put item 3 of pColor into b
    end if
    put sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b)) into hsp
    if hsp > 127.5 then
        return "black"
    else
        return "white"
    end if
end textColorForBackground

